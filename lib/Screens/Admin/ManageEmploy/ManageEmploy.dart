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

import '../../../Widget/AppColor.dart';
import '../../../Widget/AppConstants.dart';
import '../../../Widget/AppIcons.dart';
import '../../../Widget/AppSize.dart';
import '../../../Widget/AppText.dart';
import '../../../Widget/GeneralWidget.dart';
import 'AddEmploy.dart';

class ManageEmploy extends StatefulWidget {
  const ManageEmploy({Key? key}) : super(key: key);

  @override
  State<ManageEmploy> createState() => _ManageEmployState();
}

class _ManageEmployState extends State<ManageEmploy> {
  List<String> header = [
    AppMessage.employId,
    AppMessage.employName,
    AppMessage.email,
    AppMessage.phone,
    AppMessage.section,
    AppMessage.salary,
    AppMessage.contract,
    AppMessage.action,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        text: AppMessage.manageUsers,
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
                  AppRoutes.pushTo(context, const AddEmploy());
                },
                text: AppMessage.addUser,
                icon: AppIcons.add,
              ),
            ),
            Expanded(
                flex: 5,
                child: StreamBuilder(
                  stream: AppConstants.userCollection
                      .where('type', isEqualTo: AppConstants.employ)
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
                                          alignment: Alignment.center,
                                          child: AppText(
                                            text:
                                                '${data[index].data()?['name']}',
                                            fontSize: AppSize.subTextSize,
                                            overflow: TextOverflow.ellipsis,
                                          )),
//email======================================================================================================================================================
                                      TableViewCell(
                                          alignment: Alignment.center,
                                          child: AppText(
                                            text:
                                                '${data[index].data()?['email']}',
                                            fontSize: AppSize.subTextSize,
                                            overflow: TextOverflow.ellipsis,
                                          )),
//phone======================================================================================================================================================
                                      TableViewCell(
                                          alignment: Alignment.center,
                                          child: AppText(
                                            text:
                                                '0${data[index].data()?['phone']}',
                                            fontSize: AppSize.subTextSize,
                                            overflow: TextOverflow.ellipsis,
                                          )),
//section======================================================================================================================================================
                                      TableViewCell(
                                          alignment: Alignment.center,
                                          child: AppText(
                                            text:
                                                '${data[index].data()?['section']}',
                                            fontSize: AppSize.subTextSize,
                                            overflow: TextOverflow.ellipsis,
                                          )),
//salary======================================================================================================================================================
                                      TableViewCell(
                                          alignment: Alignment.center,
                                          child: AppText(
                                            text:
                                                '${data[index].data()?['salary']} ${AppMessage.RSA}',
                                            fontSize: AppSize.subTextSize,
                                            overflow: TextOverflow.ellipsis,
                                          )),
//file======================================================================================================================================================
                                      TableViewCell(
                                          alignment: Alignment.center,
                                          child: IconButton(
                                              onPressed: () async {
                                                //open file
                                                await launchUrl(Uri.parse(
                                                    data[index]
                                                        .data()?['contract']));
                                              },
                                              icon: Icon(
                                                AppIcons.file,
                                                color: Colors.black
                                                    .withOpacity(0.16),
                                                size:
                                                    AppSize.appBarIconsSize + 5,
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
                                                  onPressed: () {},
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
                                                  onPressed: () {},
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
