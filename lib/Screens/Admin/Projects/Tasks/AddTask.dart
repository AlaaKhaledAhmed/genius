import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius/BackEnd/Database/DatabaseMethods..dart';
import 'package:genius/Widget/AppBar.dart';
import 'package:genius/Widget/AppConstants.dart';
import 'package:genius/Widget/AppMessage.dart';
import 'package:genius/Widget/GeneralWidget.dart';

import '../../../../Widget/AppButtons.dart';
import '../../../../Widget/AppColor.dart';
import '../../../../Widget/AppDialog.dart';
import '../../../../Widget/AppDropList.dart';
import '../../../../Widget/AppIcons.dart';
import '../../../../Widget/AppSize.dart';
import '../../../../Widget/AppText.dart';
import '../../../../Widget/AppTextFields.dart';
import '../../../../Widget/AppValidator.dart';
import '../../../../Widget/DropList2.dart';

class AddTask extends StatefulWidget {
  final String? projectId;
  const AddTask({Key? key, this.projectId}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  String? from, to;
  DateTime? startDate, endDate;
  TextEditingController taskController = TextEditingController();
  final key1 = GlobalKey<State<StatefulWidget>>();
  final formKey = GlobalKey<FormState>();


  List<Employee> selectedEmployees = [];
  List<Employee> employees = [];
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
                    StreamBuilder<QuerySnapshot>(
                      stream: AppConstants.projectCollection
                          .where('projectId', isEqualTo: widget.projectId)
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          snapshot.data!.docs.forEach((doc) {
                            List<dynamic> employeesData = doc['employees'];
                            employees.clear();
                            employeesData.forEach((employeeData) {
                              employees.add(Employee(
                                name: employeeData['name'],
                                userId: employeeData['userId'],
                                empNumber: employeeData['empNumber'],
                              ));
                            });
                          });

                          color_print('length: ${employees.length}');
                          return StatefulBuilder(builder: (context, set) {
                            return AppDropList2(
                              value: selectedEmployees.isEmpty
                                  ? null
                                  : selectedEmployees
                                      .map((e) => e.userId)
                                      .toList()
                                      .last,
                              validator: (v) => AppValidator.validatorEmpty(v),
                              hintText: AppMessage.selectEmployee,
                              onChanged: (v) {
                                setState(() {
                                  selectedEmployees.clear();
                                  selectedEmployees.add(Employee(
                                      name: employees
                                          .where(
                                              (element) => element.userId == v)
                                          .first
                                          .name,
                                      userId: v!,
                                      empNumber: employees
                                          .where(
                                              (element) => element.userId == v)
                                          .first
                                          .empNumber));
                                });
                                set(() {});
                                selectedEmployees.forEach((element) {
                                  print(
                                      'name: ${element.name}\nuserid: ${element.userId}\ndocId: ${element.userId}');
                                });
                              },
                              items: employees
                                  .map((e) => DropdownMenuItem<String>(
                                        value: e.userId,
                                        enabled: true,
                                        child: StatefulBuilder(
                                            builder: (context, set) {
                                          return Padding(
                                              padding:
                                                  EdgeInsets.only(right: 10.w),
                                              child: AppText(
                                                  text:
                                                      '${e.name} - ${e.empNumber}',
                                                  fontSize:
                                                      AppSize.subTextSize));
                                        }),
                                      ))
                                  .toList(),

                            );
                          });
                        }
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),

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
                                    : "$from",
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
                            projectId: widget.projectId!,
                            name: selectedEmployees[0].name,
                            startDate: startDate!,
                            endDate: endDate!,
                            startDateStringFormat: from!,
                            endDateStringFormat: to!,
                            taskName: taskController.text,
                            employNumber:selectedEmployees[0].empNumber,
                            userId: selectedEmployees[0].userId,
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
