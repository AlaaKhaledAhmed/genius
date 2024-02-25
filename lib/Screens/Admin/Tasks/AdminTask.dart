import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius/Widget/AppBar.dart';
import 'package:genius/Widget/AppButtons.dart';
import 'package:genius/Widget/AppDialog.dart';
import 'package:genius/Widget/AppMessage.dart';
import 'package:genius/Widget/AppRoutes.dart';
import 'package:scrollable_table_view/scrollable_table_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../BackEnd/Database/DatabaseMethods..dart';
import '../../../Widget/AppColor.dart';
import '../../../Widget/AppConstants.dart';
import '../../../Widget/AppIcons.dart';
import '../../../Widget/AppSize.dart';
import '../../../Widget/AppText.dart';
import '../../../Widget/GeneralWidget.dart';
import 'AddTask.dart';

class AdminTask extends StatefulWidget {
  const AdminTask({super.key});

  @override
  State<AdminTask> createState() => _AdminTaskState();
}

class _AdminTaskState extends State<AdminTask> {
  List<String> header = [
    AppMessage.employId,
    AppMessage.employName,
    AppMessage.taskText,
    AppMessage.starDate,
    AppMessage.endDate,
    AppMessage.status,
    AppMessage.action,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        text: AppMessage.task,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              child: AppButtons(
                onPressed: () {
                  AppRoutes.pushTo(context, const AddTask());
                },
                text: AppMessage.addTask,
                icon: AppIcons.add,
              ),
            ),
            Expanded(
                flex: 5,
                child: StreamBuilder(
                  stream: AppConstants.taskCollection
                      .orderBy('createdOn', descending: true)
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
                                          width: 120.w,
                                        ))
                                    .toList(),
                                rows: List.generate(data.length, (index) {
                                  return TableViewRow(
                                    height: 45.h,
                                    cells: [
//employee id======================================================================================================================================================
                                      TableViewCell(
                                          alignment: Alignment.center,
                                          child: AppText(
                                            text:
                                                '${data[index].data()?['employNaId']}',
                                            fontSize: AppSize.subTextSize,
                                            overflow: TextOverflow.ellipsis,
                                          )),
//name======================================================================================================================================================
                                      TableViewCell(
                                          // padding: EdgeInsets.only(left: 15.w),
                                          alignment: Alignment.centerRight,
                                          child: TableViewCell(
                                              alignment: Alignment.center,
                                              child: AppText(
                                                text:
                                                    '${data[index].data()['name']}',
                                                fontSize: AppSize.subTextSize,
                                                overflow: TextOverflow.ellipsis,
                                              ))),
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
//star date======================================================================================================================================================
                                      TableViewCell(
                                          // padding: EdgeInsets.only(left: 15.w),
                                          alignment: Alignment.centerRight,
                                          child: TableViewCell(
                                              alignment: Alignment.center,
                                              child: AppText(
                                                text:
                                                    '${data[index].data()['startDateStringFormat']}',
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
                                          // padding: EdgeInsets.only(left: 15.w),
                                          alignment: Alignment.centerRight,
                                          child: TableViewCell(
                                              alignment: Alignment.center,
                                              child: AppText(
                                                text: data[index]
                                                            .data()['status'] ==
                                                        0
                                                    ? AppMessage
                                                        .notCompleteStatus
                                                    : AppMessage.completeStatus,
                                                fontSize: AppSize.subTextSize,
                                                // overflow: TextOverflow.ellipsis,
                                              ))),
//action======================================================================================================================================================
                                      TableViewCell(
                                          alignment: Alignment.center,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
//delete======================================================================================================================================================
                                              IconButton(
                                                  onPressed: () {
                                                    AppLoading.show(
                                                        context,
                                                        AppMessage.delete,
                                                        AppMessage.confirm,
                                                        showButtom: true,
                                                        noFunction: () {
                                                      Navigator.pop(context);
                                                    }, yesFunction: () async {
                                                      Navigator.pop(context);
                                                      await Database.delete(
                                                          collection: 'task',
                                                          docId: snapshot.data
                                                              .docs[index].id);
                                                    });
                                                  },
                                                  icon: Icon(
                                                    AppIcons.delete,
                                                    size:
                                                        AppSize.iconsSize + 10,
                                                    color: AppColor.errorColor,
                                                  )),
                                              SizedBox(
                                                width: 5.w,
                                              ),
//update============================================================================================================================================================
                                              IconButton(
                                                  onPressed: () {

                                                  },
                                                  icon: Icon(
                                                    AppIcons.update,
                                                    size:
                                                        AppSize.iconsSize + 10,
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
      ),
    );
  }
}
