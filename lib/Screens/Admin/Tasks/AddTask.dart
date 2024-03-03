import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius/BackEnd/Database/DatabaseMethods..dart';
import 'package:genius/Widget/AppBar.dart';
import 'package:genius/Widget/AppConstants.dart';
import 'package:genius/Widget/AppMessage.dart';
import 'package:genius/Widget/GeneralWidget.dart';

import '../../../Widget/AppButtons.dart';
import '../../../Widget/AppColor.dart';
import '../../../Widget/AppDialog.dart';
import '../../../Widget/AppDropList.dart';
import '../../../Widget/AppIcons.dart';
import '../../../Widget/AppSize.dart';
import '../../../Widget/AppText.dart';
import '../../../Widget/AppTextFields.dart';
import '../../../Widget/AppValidator.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  String? from, to;
  DateTime? startDate, endDate;
  TextEditingController taskController = TextEditingController();
  final key1 = GlobalKey<State<StatefulWidget>>();
  final formKey = GlobalKey<FormState>();
  String? selectedName;
  String? employeeId;
  String? empUserId;
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
          text: AppMessage.addTask,
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
//employee name-id=============================================================================
                    StreamBuilder(
                        stream: AppConstants.userCollection
                            .where('type', isEqualTo: AppConstants.employ)
                            .orderBy('createdOn', descending: true)
                            .snapshots(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            // List<DocumentSnapshot>
                            var data = snapshot.data!.docs;
                            List names = data.map((e) => e.data()).toList();

                            return AppDropList(
                              listItem: names
                                  .map((e) => '${e['name']}-${e['employNaId']}')
                                  .toList(),
                              validator: (v) => AppValidator.validatorEmpty(v),
                              hintText: AppMessage.employName,
                              onChanged: (v) {
                                selectedName = v!.split('-')[0];
                                employeeId = v.split('-')[1];
                                int index = names.indexWhere((e) =>
                                    e['name'] == selectedName &&
                                    e['employNaId'] == employeeId);
                                empUserId =
                                    '${names.elementAt(index)['userId']}';
                                setState(() {});
                                print('selectedName: $selectedName');
                                print('id: $employeeId');
                                print('uid: $empUserId');
                              },
                            );
                          }
                          return AppDropList(
                              icon: const Center(
                                child: CircularProgressIndicator(),
                              ),
                              listItem: [],
                              validator: (v) {},
                              hintText: AppMessage.employName,
                              onChanged: (v) {});
                        }),
                    SizedBox(
                      height: 10.h,
                    ),
//task name=============================================================================
                    AppTextFields(
                      key: key1,
                      onTap: () {
                        GeneralWidget.ensureVisibleOnTextArea(key: key1);
                      },
                      validator: (v) => AppValidator.validatorEmpty(v),
                      controller: taskController,
                      labelText: AppMessage.taskText,
                      maxLines: 4,
                      minLines: 4,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
//date=====================================================================================
                    GestureDetector(
                      onTap: () async {
                        List<DateTime?>? r =
                            await GeneralWidget.showDateRangDialog(
                                context: context);
                        if (r != null) {
                          ///need this format to display month name to user
                          from = GeneralWidget.convertStringToDate(r[0]);
                          to = (r.length == 1
                              ? from
                              : GeneralWidget.convertStringToDate(r[1]));
                          startDate = r[0];
                          endDate = (r.length == 1 ? startDate : r[1]);

                        }
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.only(right: 10.w),
                        alignment: AlignmentDirectional.center,
                        decoration: GeneralWidget.decoration(
                            color: AppColor.scaffoldColor,
                            showBorder: true,
                            radius: AppSize.radius,
                            borderColor: AppColor.darkGrey),
                        height: 40.h,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              AppIcons.date,
                              color: AppColor.mainColor,
                              size: AppSize.iconsSize,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
//date====================================================================================================================================
                            Padding(
                              padding: EdgeInsets.only(top: 5.0.h),
                              child: AppText(
                                text: from == null
                                    ? AppMessage.selectDate
                                    : "$from - $to",
                                fontSize: AppSize.subTextSize,
                                color: AppColor.textColor,
                              ),
                            ),
                            const Spacer(),
//clear date====================================================================================================================================
                            from == null
                                ? const SizedBox()
                                : IconButton(
                                    onPressed: () {
                                      from = null;
                                      to = null;

                                      setState(() {});
                                    },
                                    icon: Icon(
                                      Icons.clear,
                                      color: AppColor.textColor,
                                      size: AppSize.iconsSize,
                                    )),
                          ],
                        ),
                      ),
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

                          Database.addTask(
                            name: selectedName!,
                            startDate: startDate!,
                            endDate: endDate!,
                            startDateStringFormat: from!,
                            endDateStringFormat: to!,
                            taskName: taskController.text,
                            employNaId: employeeId!,
                            userId: empUserId!,
                          ).then((v) {
                            print('================$v');
                            if (v == "done") {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              AppLoading.show(
                                  context, AppMessage.addUser, AppMessage.done);
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
