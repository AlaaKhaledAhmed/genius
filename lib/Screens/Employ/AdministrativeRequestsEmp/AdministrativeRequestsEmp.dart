import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:genius/Screens/Employ/AdministrativeRequestsEmp/AddAdministrativeRequestsEmp.dart';

import '../../../BackEnd/Database/DatabaseMethods..dart';
import '../../../Widget/AppBar.dart';
import '../../../Widget/AppColor.dart';
import '../../../Widget/AppConstants.dart';
import '../../../Widget/AppIcons.dart';
import '../../../Widget/AppMessage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius/Widget/AppButtons.dart';
import 'package:genius/Widget/AppDialog.dart';
import 'package:genius/Widget/AppRoutes.dart';
import 'package:scrollable_table_view/scrollable_table_view.dart';
import '../../../Widget/AppSize.dart';
import '../../../Widget/AppText.dart';
import '../../../Widget/GeneralWidget.dart';
import '../../Admin/PDFView.dart';
import '../../Employ/AdministrativeRequestsEmp/UpdateAdministrativeRequestsEmp.dart';

class AdministrativeRequestsEmp extends StatefulWidget {
  const AdministrativeRequestsEmp({Key? key}) : super(key: key);

  @override
  State<AdministrativeRequestsEmp> createState() =>
      _AdministrativeRequestsEmpState();
}

class _AdministrativeRequestsEmpState extends State<AdministrativeRequestsEmp> {
  List<String> header = [
    AppMessage.title,
    AppMessage.text,
    AppMessage.status,
    AppMessage.replay,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        text: AppMessage.administrativeRequests,
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
                  AppRoutes.pushTo(
                      context, const AddAdministrativeRequestsEmp());
                },
                text: AppMessage.addRequest,
                icon: AppIcons.add,
              ),
            ),
            Expanded(
                flex: 5,
                child: StreamBuilder(
                  stream: AppConstants.employeeRequest
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
//title======================================================================================================================================================
                                      TableViewCell(
                                          alignment: Alignment.center,
                                          child: AppText(
                                            text:
                                                '${data[index].data()?['title']}',
                                            fontSize: AppSize.subTextSize,
                                            overflow: TextOverflow.ellipsis,
                                          )),

//text======================================================================================================================================================
                                      TableViewCell(
                                          alignment: Alignment.center,
                                          child: AppText(
                                            text:
                                                '${data[index].data()?['text']}',
                                            fontSize: AppSize.subTextSize,
                                            overflow: TextOverflow.ellipsis,
                                          )),

//status======================================================================================================================================================
                                      TableViewCell(
                                        alignment: Alignment.centerRight,
                                        child: TableViewCell(
                                          alignment: Alignment.center,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5.w, vertical: 5.h),
                                            decoration:
                                                GeneralWidget.decoration(
                                              shadow: false,
                                              radius: 5,
                                              color: data[index]
                                                          .data()['status'] ==
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
                                              color: data[index]
                                                          .data()['status'] ==
                                                      0
                                                  ? AppColor.errorColor
                                                  : AppColor.successColor,
                                              overflow: TextOverflow.ellipsis,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
//replay======================================================================================================================================================
                                      TableViewCell(
                                          alignment: Alignment.center,
                                          child: IconButton(
                                              onPressed: () {
                                                AppLoading.show(
                                                  context,
                                                  AppMessage.replay,
                                                  data[index].data()['replay'].isEmpty?AppMessage.noReplay:data[index].data()['replay'],
                                                );
                                              },
                                              icon: Icon(
                                                AppIcons.replay,
                                                size: AppSize.iconsSize + 10,
                                                color: AppColor.errorColor,
                                              ))),
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
