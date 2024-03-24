import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:math';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:genius/Widget/AppConstants.dart';
import 'package:genius/Widget/AppText.dart';
import '../../../BackEnd/Database/DatabaseMethods..dart';
import '../../../Widget/AppBar.dart';
import '../../../Widget/AppButtons.dart';
import '../../../Widget/AppColor.dart';
import '../../../Widget/AppDialog.dart';
import '../../../Widget/AppIcons.dart';
import '../../../Widget/AppMessage.dart';
import '../../../Widget/AppSize.dart';
import '../../../Widget/AppTextFields.dart';
import '../../../Widget/AppValidator.dart';
import '../../../Widget/GeneralWidget.dart';

class AddAdministrativeRequestsEmp extends StatefulWidget {
  final String userId;
  const AddAdministrativeRequestsEmp({Key? key, required this.userId})
      : super(key: key);

  @override
  State<AddAdministrativeRequestsEmp> createState() =>
      _AddAdministrativeRequestsEmpState();
}

class _AddAdministrativeRequestsEmpState
    extends State<AddAdministrativeRequestsEmp> {
  TextEditingController textController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  final _key1 = GlobalKey<State<StatefulWidget>>();
  final _key2 = GlobalKey<State<StatefulWidget>>();
  final _key3 = GlobalKey<State<StatefulWidget>>();
  final _key4 = GlobalKey<State<StatefulWidget>>();
  final formKey = GlobalKey<FormState>();
  String? from, to;
  DateTime? startDate, endDate;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
//emp name =============================================================================
                    StreamBuilder(
                        stream: AppConstants.userCollection
                            .where('userId', isEqualTo: widget.userId)
                            .snapshots(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            var data = snapshot.data!.docs;
                            nameController.text = data[0].data()['name'];
                            return AppTextFields(
                              key: _key1,
                              onTap: () {
                                GeneralWidget.ensureVisibleOnTextArea(
                                    key: _key1);
                              },
                              validator: (v) => AppValidator.validatorEmpty(v),
                              controller: nameController,
                              labelText: AppMessage.employName,
                              readOnly: true,
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }),
                    SizedBox(
                      height: 10.h,
                    ),
//emp number=============================================================================
                    StreamBuilder(
                        stream: AppConstants.userCollection
                            .where('userId', isEqualTo: widget.userId)
                            .snapshots(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            var data = snapshot.data.docs;
                            numberController.text =
                                data[0].data()['employNumber'];
                            return AppTextFields(
                              key: _key2,
                              onTap: () {
                                GeneralWidget.ensureVisibleOnTextArea(
                                    key: _key2);
                              },
                              validator: (v) => AppValidator.validatorEmpty(v),
                              controller: numberController,
                              labelText: AppMessage.employeeNumber,
                              readOnly: true,
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }),
                    SizedBox(
                      height: 10.h,
                    ),
//title=============================================================================
                    AppTextFields(
                      key: _key3,
                      onTap: () {
                        GeneralWidget.ensureVisibleOnTextArea(key: _key3);
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
                      key: _key4,
                      onTap: () {
                        GeneralWidget.ensureVisibleOnTextArea(key: _key4);
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
//date=====================================================================================
                    AppTextFields(
                      validator: (v) => AppValidator.validatorEmpty(v),
                      controller: dateController,
                      labelText: AppMessage.selectDateRequest,
                      onTap: () async {
                        List<DateTime?>? r =
                            await GeneralWidget.showDateRangDialog(
                                showRange: true, context: context);
                        if (r != null) {
                          ///need this format to display month name to user
                          from = GeneralWidget.convertStringToDate(r[0]);
                          to = (r.length == 1
                              ? from
                              : GeneralWidget.convertStringToDate(r[1]));
                          startDate = r[0];
                          endDate = (r.length == 1 ? startDate : r[1]);
                          dateController.text = from == null
                              ? AppMessage.selectDateRequest
                              : "$from - $to";
                        }
                        setState(() {});
                      },
                      readOnly: true,
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
                            userId: widget.userId,
                            title: titleController.text,
                            text: textController.text,
                            employNumber: numberController.text,
                            name: nameController.text,
                            startDate: startDate!,
                            endDate: endDate!,
                          ).then((v) {
                            print('================$v');
                            if (v == "done") {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              AppLoading.show(context, AppMessage.addRequest,
                                  AppMessage.done);
                            } else {
                              Navigator.pop(context);
                              AppLoading.show(context, AppMessage.addRequest,
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
