import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:genius/Screens/Employ/EmployeeTasks/UplodeFile.dart';
import '../../../../BackEnd/Database/DatabaseMethods..dart';
import '../../../../Widget/AppColor.dart';

import '../../../../Widget/GeneralWidget.dart';

import '../../../../Widget/AppConstants.dart';
import '../../../../Widget/AppIcons.dart';
import '../../../../Widget/AppSize.dart';
import '../../../../Widget/AppText.dart';
import '../../../Widget/AppBar.dart';
import '../../../Widget/AppMessage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius/Widget/AppDialog.dart';
import 'package:genius/Widget/AppRoutes.dart';
import 'package:scrollable_table_view/scrollable_table_view.dart';

import '../../Admin/PDFView.dart';

class EmployeeTask extends StatefulWidget {
  const EmployeeTask({super.key});

  @override
  State<EmployeeTask> createState() => _EmployeeTaskState();
}

class _EmployeeTaskState extends State<EmployeeTask> {
  late String? userId;
  int selectedIndex = 1;
  List<String> header = [
    AppMessage.taskText,
    AppMessage.endDate,
    AppMessage.status,
    AppMessage.attachment,
    AppMessage.action,
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      userId = FirebaseAuth.instance.currentUser?.uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        text: AppMessage.task,
        isEmp: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          Row(
            children: [
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                  child: InkWell(
                onTap: () {
                  setState(() {
                    selectedIndex = 1;
                  });
                },
                child: Container(
                  alignment: AlignmentDirectional.center,
                  padding: EdgeInsets.all(15.spMin),
                  decoration: GeneralWidget.decoration(
                      color: selectedIndex == 1
                          ? AppColor.subColor
                          : AppColor.white),
                  child: AppText(
                    text: AppMessage.indTask,
                    fontSize: AppSize.subTextSize,
                  ),
                ),
              )),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                  child: InkWell(
                onTap: () {
                  setState(() {
                    selectedIndex = 2;
                  });
                },
                child: Container(
                  alignment: AlignmentDirectional.center,
                  padding: EdgeInsets.all(15.spMin),
                  decoration: GeneralWidget.decoration(
                      color: selectedIndex == 2
                          ? AppColor.subColor
                          : AppColor.white),
                  child: AppText(
                    text: AppMessage.prTask,
                    fontSize: AppSize.subTextSize,
                  ),
                ),
              )),
              SizedBox(
                width: 10.w,
              ),
            ],
          ),
          Expanded(
              flex: 5,
              child: StreamBuilder(
                stream: (selectedIndex == 2
                        ? AppConstants.taskCollection
                        : AppConstants.individualTasksCollection)
                    .where('userId', isEqualTo: userId)
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: AppText(
                          text: AppMessage.serverText,
                          fontSize: AppSize.subTextSize),
                    );
                  } else if (snapshot.hasData) {
                    var data = snapshot.data!.docs;
                    return data.isEmpty
                        ? GeneralWidget.emptyData(context: context)
                        : MediaQuery.removePadding(
                            removeBottom: true,
                            context: context,
                            child: ScrollableTableView(
                              rowDividerHeight: 0.5.spMin,
                              headerHeight: 40.h,
                              headerBackgroundColor: AppColor.deepLightGrey,
//headers======================================================================================================================================================
                              headers: header
                                  .map((e) => TableViewHeader(
                                        label: e,
                                        textStyle: TextStyle(
                                            color: AppColor.black,
                                            fontWeight: FontWeight.normal),
                                        alignment: Alignment.center,
                                        width: 150.w,
                                      ))
                                  .toList(),
                              rows: List.generate(data.length, (index) {
                                return TableViewRow(
                                  height: 45.h,
                                  cells: [
//task======================================================================================================================================================
                                    TableViewCell(
                                        // padding: EdgeInsets.only(left: 15.w),
                                        alignment: Alignment.centerRight,
                                        child: TableViewCell(
                                            alignment: Alignment.center,
                                            child: AppText(
                                              text:
                                                  '${data[index].data()['taskName']}',
                                              fontSize: AppSize.subTextSize,
                                              // overflow: TextOverflow.ellipsis,
                                            ))),

//end date======================================================================================================================================================
                                    TableViewCell(
                                        // padding: EdgeInsets.only(left: 15.w),
                                        alignment: Alignment.centerRight,
                                        child: TableViewCell(
                                            alignment: Alignment.center,
                                            child: AppText(
                                              text:
                                                  '${data[index].data()['endDateStringFormat']}',
                                              fontSize: AppSize.subTextSize,
                                              // overflow: TextOverflow.ellipsis,
                                            ))),
//status======================================================================================================================================================
                                    TableViewCell(
                                      alignment: Alignment.centerRight,
                                      child: TableViewCell(
                                        alignment: Alignment.center,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5.w, vertical: 5.h),
                                          decoration: GeneralWidget.decoration(
                                            shadow: false,
                                            radius: 5,
                                            color:
                                                data[index].data()['status'] ==
                                                        0
                                                    ? AppColor.errorColor
                                                        .withOpacity(0.2)
                                                    : AppColor.successColor
                                                        .withOpacity(0.3),
                                          ),
                                          child: AppText(
                                            text: data[index]
                                                        .data()['status'] ==
                                                    0
                                                ? AppMessage.notCompleteStatus
                                                : AppMessage.completeStatus,
                                            fontSize: AppSize.smallSubText,
                                            color:
                                                data[index].data()['status'] ==
                                                        0
                                                    ? AppColor.errorColor
                                                    : AppColor.successColor,
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
//file======================================================================================================================================================
                                    TableViewCell(
                                        alignment: Alignment.center,
                                        child: data[index]
                                                .data()?['file']
                                                .isEmpty
                                            ? Text('-')
                                            : IconButton(
                                                onPressed: () async {
                                                  //open file
                                                  ///open pdf view
                                                  showGeneralDialog(
                                                    context: context,
                                                    pageBuilder: (
                                                      BuildContext context,
                                                      Animation<double>
                                                          animation,
                                                      Animation<double>
                                                          secondaryAnimation,
                                                    ) {
                                                      return PDFViewerPage(
                                                        pdfUrl: data[index]
                                                            .data()?['file'],
                                                        titleName:
                                                            AppMessage.file,
                                                      );
                                                    },
                                                  );
                                                },
                                                icon: Icon(
                                                  AppIcons.file,
                                                  color: Colors.black
                                                      .withOpacity(0.16),
                                                  size: AppSize.iconsSize + 10,
                                                ))),

//action======================================================================================================================================================
                                    TableViewCell(
                                        alignment: Alignment.center,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
//update============================================================================================================================================================
                                            IconButton(
                                                onPressed: () {
                                                  AppRoutes.pushTo(
                                                    context,
                                                    UplodeFile(
                                                        type: selectedIndex,
                                                        docId: snapshot.data
                                                            .docs[index].id),
                                                  );
                                                },
                                                icon: Icon(
                                                  Icons.upload,
                                                  size: AppSize.iconsSize + 10,
                                                  color: AppColor.mainColor,
                                                )),
                                          ],
                                        )),
                                  ],
                                );
                              }),
                            ));
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                  //
                },
              ))
        ],
      ),
    );
  }
}
