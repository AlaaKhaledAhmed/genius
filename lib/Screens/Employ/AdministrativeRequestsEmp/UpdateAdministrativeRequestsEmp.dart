import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:math';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../BackEnd/Database/DatabaseMethods..dart';
import '../../../Widget/AppBar.dart';
import '../../../Widget/AppButtons.dart';
import '../../../Widget/AppColor.dart';
import '../../../Widget/AppDialog.dart';
import '../../../Widget/AppIcons.dart';
import '../../../Widget/AppMessage.dart';
import '../../../Widget/AppSize.dart';
import '../../../Widget/AppText.dart';
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
    startDate = widget.data['startDate'].toDate();
    endDate = widget.data['endDate'].toDate();
    from =
        GeneralWidget.convertStringToDate((widget.data['startDate']).toDate());
    to = GeneralWidget.convertStringToDate((widget.data['endDate']).toDate());
    dateController.text = "$from - $to";
  }

  TextEditingController textController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  final _key1 = GlobalKey<State<StatefulWidget>>();
  final _key2 = GlobalKey<State<StatefulWidget>>();
  String? from, to;
  DateTime? startDate, endDate;
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
                            startDate: startDate!,
                            endDate: endDate!,
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
