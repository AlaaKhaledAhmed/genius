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

class AddEmploy extends StatefulWidget {
  const AddEmploy({Key? key}) : super(key: key);

  @override
  State<AddEmploy> createState() => _AddEmployState();
}

class _AddEmployState extends State<AddEmploy> {
  TextEditingController nameController = TextEditingController();
  TextEditingController employNumberController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  TextEditingController fileController = TextEditingController();
  final _key1 = GlobalKey<State<StatefulWidget>>();
  final _key2 = GlobalKey<State<StatefulWidget>>();
  final _key3 = GlobalKey<State<StatefulWidget>>();
  final _key4 = GlobalKey<State<StatefulWidget>>();
  final _key5 = GlobalKey<State<StatefulWidget>>();
  final _key6 = GlobalKey<State<StatefulWidget>>();
  final _key7 = GlobalKey<State<StatefulWidget>>();
  final formKey = GlobalKey<FormState>();
  String? section;
  String? nationalities;
  Reference? fileRef;
  String? fileURL;
  File? file;
  @override
  Widget build(BuildContext context) {
    var bottom = MediaQuery.of(context).viewInsets.bottom;
    bottom = max(min(bottom, 185.h), 0);
color_print( context.locale.toString());
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBarWidget(
          text: AppMessage.addUser,
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
//name=============================================================================
                    AppTextFields(
                      key: _key2,
                      onTap: () {
                        GeneralWidget.ensureVisibleOnTextArea(key: _key2);
                      },
                      validator: (v) => AppValidator.validatorName(v),
                      controller: nameController,
                      labelText: AppMessage.employName,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
//employee number=============================================================================
                    AppTextFields(
                      key: _key7,
                      onTap: () {
                        GeneralWidget.ensureVisibleOnTextArea(key: _key7);
                      },
                      validator: (v) => AppValidator.validatorId(v),
                      controller: employNumberController,
                      labelText: AppMessage.employeeNumber,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
//employee identity=============================================================================
                    AppTextFields(
                      key: _key1,
                      onTap: () {
                        GeneralWidget.ensureVisibleOnTextArea(key: _key1);
                      },
                      validator: (v) => AppValidator.validatorId(v),
                      controller: idController,
                      labelText: AppMessage.employId,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),


//Nationalities=============================================================================
                    AppDropList(
                      items: context.locale.toString() == 'ar'
                          ? AppConstants.arabicNationalities
                          : AppConstants.englishNationalities,
                      validator: (v) => AppValidator.validatorEmpty(v),
                      hintText: AppMessage.nationalities,
                      onChanged: (v) {
                        nationalities = v;
                        setState(() {});
                      },
                      // dropValue: section
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
//section=============================================================================
                    AppDropList(
                      items: context.locale.toString() == 'ar'
                          ? AppConstants.sectionListAr
                          : AppConstants.sectionListEn,
                      validator: (v) => AppValidator.validatorEmpty(v),
                      hintText: AppMessage.section,
                      onChanged: (v) {
                        section = v;
                        setState(() {});
                      },
                      // dropValue: section
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
//email=============================================================================
                    AppTextFields(
                      key: _key3,
                      onTap: () {
                        GeneralWidget.ensureVisibleOnTextArea(key: _key3);
                      },
                      validator: (v) => AppValidator.validatorEmail(v),
                      controller: emailController,
                      labelText: AppMessage.email,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
//file=============================================================================
                    AppTextFields(
                      key: _key4,
                      onTap: () {
                        GeneralWidget.ensureVisibleOnTextArea(key: _key4);
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
                      labelText: AppMessage.contract,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
//salary=============================================================================
                    AppTextFields(
                      key: _key5,
                      onTap: () {
                        GeneralWidget.ensureVisibleOnTextArea(key: _key5);
                      },
                      validator: (v) => AppValidator.validatorEmpty(v),
                      controller: salaryController,
                      labelText: AppMessage.salary,
                      keyboardType: TextInputType.phone,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
//phone=============================================================================
                    AppTextFields(
                        key: _key6,
                        onTap: () {
                          GeneralWidget.ensureVisibleOnTextArea(key: _key6);
                        },
                        validator: (v) => AppValidator.validatorPhone(v),
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        labelText: AppMessage.phone,
                        textAlignment: TextAlign.start,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        maxLines: 2,
                        suffixIcon: Container(
                          width: 55.w,
                          decoration: BoxDecoration(
                              border: Border(
                                  right: BorderSide(
                                      color: AppColor.deepLightGrey))),
                          child: Center(
                            child: AppText(
                              text: AppMessage.phoneKey,
                              fontSize: AppSize.textFieldsSize,
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 10.h,
                    ),
//save buttons=============================================================================
                    AppButtons(
                      text: AppMessage.add,
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
                            Database.addEmploy(
                              name: nameController.text,
                              contract: fileURL!,
                              email: emailController.text,
                              employNaId: idController.text,
                              phone: phoneController.text,
                              salary: salaryController.text,
                              employNumber: employNumberController.text,
                              nationalities: nationalities!,
                              section: section.toString(),
                            ).then((v) {
                              print('================$v');
                              if (v == "done") {
                                Navigator.pop(context);
                                Navigator.pop(context);
                                AppLoading.show(context, AppMessage.addUser,
                                    AppMessage.done);
                              } else if (v == "email-already-in-use") {
                                Navigator.pop(context);
                                AppLoading.show(context, AppMessage.addUser,
                                    AppMessage.emailAlreadyInUse);
                              } else {
                                Navigator.pop(context);
                                AppLoading.show(context, AppMessage.addUser,
                                    AppMessage.serverText);
                              }
                            });
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
