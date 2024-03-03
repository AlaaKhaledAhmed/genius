import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:math';
import 'package:path/path.dart' as path;
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius/Widget/AppConstants.dart';
import 'package:genius/Widget/AppDropList.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../BackEnd/Database/DatabaseMethods..dart';
import '../../../Widget/AppBar.dart';
import '../../../Widget/AppButtons.dart';
import '../../../Widget/AppColor.dart';
import '../../../Widget/AppDialog.dart';
import '../../../Widget/AppMessage.dart';
import '../../../Widget/AppRoutes.dart';
import '../../../Widget/AppSize.dart';
import '../../../Widget/AppText.dart';
import '../../../Widget/AppTextFields.dart';
import '../../../Widget/AppValidator.dart';
import '../../../Widget/GeneralWidget.dart';

class UpdateAdministrativeCircular extends StatefulWidget {
  final String docId;
  final data;
  const UpdateAdministrativeCircular(
      {super.key, required this.docId, required this.data});

  @override
  State<UpdateAdministrativeCircular> createState() =>
      _UpdateAdministrativeCircularState();
}

class _UpdateAdministrativeCircularState
    extends State<UpdateAdministrativeCircular> {
  TextEditingController fileController = TextEditingController();
  TextEditingController textController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  final _key1 = GlobalKey<State<StatefulWidget>>();
  final _key2 = GlobalKey<State<StatefulWidget>>();
  final _key3 = GlobalKey<State<StatefulWidget>>();
  final formKey = GlobalKey<FormState>();
  Reference? fileRef;
  String? fileURL;
  File? file;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    textController.text = widget.data['text'];

    titleController.text = widget.data['title'];
    fileController.text = widget.data['file'];
  }

  @override
  Widget build(BuildContext context) {
    var bottom = MediaQuery.of(context).viewInsets.bottom;
    bottom = max(min(bottom, 185.h), 0);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBarWidget(
          text: AppMessage.addAdministrativeCircular,
          isBasics: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(bottom: bottom),
                child: Column(
                  children: [
//title=============================================================================
                    AppTextFields(
                      key: _key1,
                      onTap: () {
                        GeneralWidget.ensureVisibleOnTextArea(key: _key1);
                      },
                      validator: (v) => AppValidator.validatorEmpty(v),
                      controller: titleController,
                      labelText: AppMessage.title,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
//text=============================================================================
                    AppTextFields(
                      key: _key2,
                      onTap: () {
                        GeneralWidget.ensureVisibleOnTextArea(key: _key2);
                      },
                      validator: (v) => AppValidator.validatorEmpty(v),
                      controller: textController,
                      labelText: AppMessage.text,
                      minLines: 3,
                      maxLines: 3,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
//file=============================================================================
                    AppTextFields(
                      key: _key3,
                      onTap: () {
                        GeneralWidget.ensureVisibleOnTextArea(key: _key3);
                        setState(() {
                          getFile(context).whenComplete(() {
                            fileController.text = (file == null
                                ? fileController.text
                                : path.basename(file!.path));
                          });
                        });
                      },
                      validator: (v) {},
                      controller: fileController,
                      labelText: AppMessage.file,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
//save buttons=============================================================================
                    AppButtons(
                      text: AppMessage.update,
                      width: double.maxFinite,
                      onPressed: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (formKey.currentState?.validate() == true) {
                          AppLoading.show(context, '', 'lode');

                          ///if chang file
                          file != null
                              ? {
                                  fileRef = FirebaseStorage.instance
                                      .ref('project')
                                      .child(fileController.text),
                                  await fileRef
                                      ?.putFile(file!)
                                      .then((getValue) async {
                                    fileURL = await fileRef!.getDownloadURL();
                                    Database.updateAdministrativeCircular(
                                      docId: widget.docId,
                                      text: textController.text,
                                      title: titleController.text,
                                      file: fileURL!,
                                    ).then((v) {
                                      print('================$v');
                                      if (v == "done") {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        AppLoading.show(
                                            context,
                                            AppMessage.administrativeCircular,
                                            AppMessage.done);
                                      } else {
                                        Navigator.pop(context);
                                        AppLoading.show(
                                            context,
                                            AppMessage.administrativeCircular,
                                            AppMessage.serverText);
                                      }
                                    });
                                  }),
                                }
                              : {
                                  Database.updateAdministrativeCircular(
                                    title: titleController.text,
                                    docId: widget.docId,
                                    text: textController.text,
                                    file: fileController.text,
                                  ).then((v) {
                                    print('================$v');
                                    if (v == "done") {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      AppLoading.show(
                                          context,
                                          AppMessage.addAdministrativeCircular,
                                          AppMessage.done);
                                    } else {
                                      Navigator.pop(context);
                                      AppLoading.show(
                                          context,
                                          AppMessage.addAdministrativeCircular,
                                          AppMessage.serverText);
                                    }
                                  }),
                                };
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  //show file picker=========================================
  Future getFile(context) async {
    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: ['pdf']);
    if (pickedFile == null) {
      return;
    }
    setState(() {
      file = File(pickedFile.paths.first!);
    });
  }
}
