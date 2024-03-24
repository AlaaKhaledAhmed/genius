import 'package:flutter/material.dart';
 import 'dart:io';
import 'dart:math';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../BackEnd/Database/DatabaseMethods..dart';
import '../../../Widget/AppBar.dart';
import '../../../Widget/AppButtons.dart';
import '../../../Widget/AppDialog.dart';
import '../../../Widget/AppMessage.dart';
import '../../../Widget/AppTextFields.dart';
import '../../../Widget/AppValidator.dart';
import '../../../Widget/GeneralWidget.dart';

class AddAdministrativeRequestsEmp extends StatefulWidget {
  const AddAdministrativeRequestsEmp({Key? key}) : super(key: key);

  @override
  State<AddAdministrativeRequestsEmp> createState() =>
      _AddAdministrativeRequestsEmpState();
}

class _AddAdministrativeRequestsEmpState
    extends State<AddAdministrativeRequestsEmp> {
  TextEditingController textController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  final _key1 = GlobalKey<State<StatefulWidget>>();
  final _key2 = GlobalKey<State<StatefulWidget>>();

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
          text: AppMessage.addRequest,
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
//save buttons=============================================================================
                    AppButtons(
                      text: AppMessage.add,
                      width: double.maxFinite,
                      onPressed: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (formKey.currentState?.validate() == true) {
                          AppLoading.show(context, '', 'lode');
                          Database.addEmployeeRequest(
                            title: titleController.text,
                            text: textController.text,
                          ).then((v) {
                            print('================$v');
                            if (v == "done") {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              AppLoading.show(
                                  context,
                                  AppMessage.addRequest,
                                  AppMessage.done);
                            } else {
                              Navigator.pop(context);
                              AppLoading.show(
                                  context,
                                  AppMessage.addRequest,
                                  AppMessage.serverText);
                            }
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
}
