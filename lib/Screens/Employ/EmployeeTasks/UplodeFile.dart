import 'dart:io';
import 'dart:math';
import 'package:genius/Widget/AppText.dart';
import 'package:path/path.dart' as path;

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../BackEnd/Database/DatabaseMethods..dart';
import '../../../Widget/AppBar.dart';
import '../../../Widget/AppButtons.dart';
import '../../../Widget/AppDialog.dart';
import '../../../Widget/AppMessage.dart';
import '../../../Widget/AppTextFields.dart';
import '../../../Widget/AppValidator.dart';
import '../../../Widget/GeneralWidget.dart';

class UplodeFile extends StatefulWidget {
  final String docId;
  final int type;
  const UplodeFile({super.key, required this.docId, required this.type});

  @override
  State<UplodeFile> createState() => _UplodeFileState();
}

class _UplodeFileState extends State<UplodeFile> {
  TextEditingController fileController = TextEditingController();
  final _key1 = GlobalKey<State<StatefulWidget>>();
  final formKey = GlobalKey<FormState>();

  Reference? fileRef;
  String? fileURL;
  File? file;
  @override
  Widget build(BuildContext context) {
    var bottom = MediaQuery.of(context).viewInsets.bottom;
    bottom = max(min(bottom, 185.h), 0);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBarWidget(
          text: AppMessage.uplodeFile,
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
//file=============================================================================
                    AppTextFields(
                      key: _key1,
                      onTap: () {
                        GeneralWidget.ensureVisibleOnTextArea(key: _key1);
                        setState(() {
                          getFile(context).whenComplete(() {
                            fileController.text = (file == null
                                ? fileController.text
                                : path.basename(file!.path));
                          });
                        });
                      },
                      validator: (v) => AppValidator.validatorEmpty(v),
                      controller: fileController,
                      labelText: AppMessage.file,
                      minLines: 4,
                      maxLines: 4,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
//save buttons=============================================================================
                    AppButtons(
                      text: AppMessage.uplodeFile,
                      width: double.maxFinite,
                      onPressed: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (formKey.currentState?.validate() == true) {
                          AppLoading.show(context, '', 'lode');
                          fileRef = FirebaseStorage.instance
                              .ref('project')
                              .child(fileController.text);
                          await fileRef?.putFile(file!).then((getValue) async {
                            fileURL = await fileRef!.getDownloadURL();

                            widget.type == 2
                                ? {
                              color_print('updateTaskStatus'),
                                    Database.updateTaskStatus(
                                            file: fileURL,
                                            docId: widget.docId,
                                            status: 1)
                                        .then((v) {
                                      print('================$v');
                                      if (v == "done") {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        AppLoading.show(
                                            context,
                                            AppMessage.uplodeFile,
                                            AppMessage.done);
                                      } else {
                                        Navigator.pop(context);
                                        AppLoading.show(
                                            context,
                                            AppMessage.uplodeFile,
                                            AppMessage.serverText);
                                      }
                                    })
                                  }
                                : {
                              color_print('updateIndividualTaskStatus'),
                                    Database.updateIndividualTaskStatus(
                                            file: fileURL,
                                            docId: widget.docId,
                                            status: 1)
                                        .then((v) {
                                      print('================$v');
                                      if (v == "done") {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        AppLoading.show(
                                            context,
                                            AppMessage.uplodeFile,
                                            AppMessage.done);
                                      } else {
                                        Navigator.pop(context);
                                        AppLoading.show(
                                            context,
                                            AppMessage.uplodeFile,
                                            AppMessage.serverText);
                                      }
                                    })
                                  };
                          });
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
