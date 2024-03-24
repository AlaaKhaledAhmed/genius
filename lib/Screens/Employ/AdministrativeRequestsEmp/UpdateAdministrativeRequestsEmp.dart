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

class UpdateAdministrativeRequestsEmp extends StatefulWidget {
  final String docId;
  final data;
  const UpdateAdministrativeRequestsEmp(
      {Key? key, required this.docId, required this.data})
      : super(key: key);

  @override
  State<UpdateAdministrativeRequestsEmp> createState() =>
      _UpdateAdministrativeRequestsEmpState();
}

class _UpdateAdministrativeRequestsEmpState
    extends State<UpdateAdministrativeRequestsEmp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    textController.text = widget.data['text'];
    titleController.text = widget.data['title'];
  }
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
          text: AppMessage.updateRequest,
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
                      text: AppMessage.update,
                      width: double.maxFinite,
                      onPressed: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (formKey.currentState?.validate() == true) {
                          AppLoading.show(context, '', 'lode');
                          Database.updateEmployeeRequest(
                            title: titleController.text,
                            text: textController.text,
                            docId: widget.docId,
                          ).then((v) {
                            print('================$v');
                            if (v == "done") {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              AppLoading.show(context, AppMessage.updateRequest,
                                  AppMessage.done);
                            } else {
                              Navigator.pop(context);
                              AppLoading.show(context, AppMessage.updateRequest,
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
