import 'dart:io';
import 'dart:math';
import 'package:path/path.dart' as path;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../BackEnd/Database/DatabaseMethods..dart';
import '../../../Widget/AppBar.dart';
import '../../../Widget/AppButtons.dart';
import '../../../Widget/AppCheckBox.dart';
import '../../../Widget/AppColor.dart';
import '../../../Widget/AppConstants.dart';
import '../../../Widget/AppDialog.dart';
import '../../../Widget/AppDropList.dart';
import '../../../Widget/AppIcons.dart';
import '../../../Widget/AppMessage.dart';
import '../../../Widget/AppSize.dart';
import '../../../Widget/AppText.dart';
import '../../../Widget/AppTextFields.dart';
import '../../../Widget/AppValidator.dart';
import '../../../Widget/DropList2.dart';
import '../../../Widget/GeneralWidget.dart';

class AddProject extends StatefulWidget {
  const AddProject({Key? key}) : super(key: key);

  @override
  State<AddProject> createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProject> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  final _key3 = GlobalKey<State<StatefulWidget>>();
  final key2 = GlobalKey<State<StatefulWidget>>();
  final key1 = GlobalKey<State<StatefulWidget>>();
  final formKey = GlobalKey<FormState>();
  TextEditingController fileController = TextEditingController();

  List<Employee> selectedEmployees = [];
  List<Employee> employees = [];
  String? from, to;
  DateTime? startDate, endDate;
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
          text: AppMessage.addProject,
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
                      stream: AppConstants.userCollection
                          .where('type', isEqualTo: AppConstants.employ)
                          .orderBy('createdOn', descending: true)
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          employees =
                              snapshot.data!.docs.map((DocumentSnapshot doc) {
                            return Employee(
                                name: doc['name'],
                                userId: doc['userId'],
                                empNumber: doc['employNumber']);
                          }).toList();

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
                                  selectedEmployees
                                          .map((e) => e.userId)
                                          .toList()
                                          .contains(v)
                                      ? selectedEmployees.removeWhere(
                                          (element) => element.userId == v)
                                      : selectedEmployees.add(Employee(
                                          name: employees
                                              .where((element) =>
                                                  element.userId == v)
                                              .first
                                              .name,
                                          userId: v!,
                                          empNumber: employees
                                              .where((element) =>
                                                  element.userId == v)
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
                                            child: AppCheckBox(
                                              label:
                                                  '${e.name} - ${e.empNumber}',
                                              value: selectedEmployees
                                                  .map((e) => e.userId)
                                                  .toList()
                                                  .contains(e.userId),
                                              onChanged: (bool? value) {
                                                if (value == true) {
                                                  selectedEmployees.add(e);
                                                } else {
                                                  selectedEmployees.remove(e);
                                                }
                                                setState(() {});
                                                set(() {});
                                                selectedEmployees
                                                    .forEach((element) {
                                                  print(
                                                      'selectedCategoryCategories: ${element.name}-${element.userId}');
                                                });
                                              },
                                            ),
                                          );
                                        }),
                                      ))
                                  .toList(),
                              selectedItemBuilder: (c) {
                                return employees.map(
                                  (item) {
                                    return SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.60,
                                        child: AppText(
                                          text: selectedEmployees.isEmpty
                                              ? AppMessage.selectEmployee
                                              : selectedEmployees
                                                  .map((e) => e.name)
                                                  .toList()
                                                  .join(', '),
                                          fontSize: AppSize.subTextSize,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ));
                                  },
                                ).toList();
                              },
                            );
                          });
                        }
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),

                    SizedBox(
                      height: 10.h,
                    ),
//project name=============================================================================
                    AppTextFields(
                      key: key1,
                      onTap: () {
                        GeneralWidget.ensureVisibleOnTextArea(key: key1);
                      },
                      validator: (v) => AppValidator.validatorEmpty(v),
                      controller: nameController,
                      labelText: AppMessage.projectName,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
//price =============================================================================
                    AppTextFields(
                      key: key2,
                      onTap: () {
                        GeneralWidget.ensureVisibleOnTextArea(key: key2);
                      },
                      validator: (v) => AppValidator.validatorNumbers(v),
                      controller: priceController,
                      labelText: AppMessage.projectPrice,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
//date=====================================================================================
                    GestureDetector(
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
//selected date====================================================================================================================================
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
                      validator: (v) => AppValidator.validatorEmpty(v),
                      controller: fileController,
                      labelText: AppMessage.contract,
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

                          Database.addProject(
                                  projectId: GeneralWidget.randomNumber(9),
                                  name: nameController.text,
                                  startDate: startDate!,
                                  endDate: endDate!,
                                  price: double.parse(priceController.text),
                                  employees: selectedEmployees)
                              .then((v) {
                            print('================$v');
                            if (v == "done") {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              AppLoading.show(context, AppMessage.addProject,
                                  AppMessage.done);
                            } else {
                              Navigator.pop(context);
                              AppLoading.show(context, AppMessage.addProject,
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
