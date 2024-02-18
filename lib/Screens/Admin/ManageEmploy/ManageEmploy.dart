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
                  stream: AppConstants.userCollection.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: AppText(
                            text: AppMessage.serverText,
                            fontSize: AppSize.subTextSize),
                      );
                    } else if (snapshot.hasData) {
                      List<QueryDocumentSnapshot> data = snapshot.data!.docs;
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
//number======================================================================================================================================================
                                      TableViewCell(
                                        padding: EdgeInsets.only(
                                            left: 30.w, right: 10),
                                        alignment: Alignment.center,
                                        //child:
                                        // AppText(
                                        //   text: data[index]
                                        //       .id
                                        //       .toString()
                                        //       .padLeft(2, '0'),
                                        //   fontSize: AppSize.subTextSize,
                                        //   overflow: TextOverflow.ellipsis,
                                        // )
                                      ),
//name-image ======================================================================================================================================================
                                      TableViewCell(
                                        // padding: EdgeInsets.only(left: 15.w),
                                        alignment: Alignment.centerRight,
                                        // child: AppText(
                                        //   text: data[index]['name'].toString(),
                                        //   fontSize: AppSize.subTextSize,
                                        //   overflow: TextOverflow.ellipsis,
                                        // )
                                      ),
//date======================================================================================================================================================
                                      TableViewCell(
                                        alignment: Alignment.center,
                                        // child: AppText(
                                        //   text: GeneralWidget.convertStringToDate(
                                        //       data[index].createdAt),
                                        //   fontSize: AppSize.subTitle,
                                        //   overflow: TextOverflow.ellipsis,
                                        // )
                                      ),
//status======================================================================================================================================================
                                      TableViewCell(
                                        alignment: Alignment.center,
                                        // child: AppText(
                                        //   text: data[index]['name'].toString(),
                                        //   fontSize: AppSize.subTextSize,
                                        //   overflow: TextOverflow.ellipsis,
                                        // )
                                      ),
//file======================================================================================================================================================
                                      TableViewCell(
                                        alignment: Alignment.center,
                                        // child: IconButton(
                                        //     onPressed: () async {
                                        //       //open file
                                        //       await launchUrl(Uri.parse(
                                        //           data[index].verifiedFile!));
                                        //     },
                                        //     icon: Icon(
                                        //       AppIcons.show,
                                        //       color:
                                        //           Colors.black.withOpacity(0.16),
                                        //       size: AppSize.appBarIconsSize + 5,
                                        //     ))
                                      ),
//action======================================================================================================================================================
                                      TableViewCell(
                                        padding: EdgeInsets.only(left: 10.w),
                                        alignment: Alignment.center,
                                        //                                       child:
                                        //                                       Row(
                                        //                                         crossAxisAlignment:
                                        //                                             CrossAxisAlignment.center,
                                        //                                         mainAxisSize: MainAxisSize.min,
                                        //                                         children: data[index]
                                        //                                                     .verifiedStatus!
                                        //                                                     .id !=
                                        //                                                 AppConstants.statusNew
                                        //                                             ? [const Text('-')]
                                        //                                             : [
                                        // //accept======================================================================================================================================================
                                        //                                                 InkWell(
                                        //                                                   onTap: () async {
                                        //                                                     AppDialog.confirmDialog(
                                        //                                                         context: context,
                                        //                                                         title:
                                        //                                                             AppMessage.accept,
                                        //                                                         content: AppMessage
                                        //                                                             .acceptConfirm,
                                        //                                                         yesColor:
                                        //                                                             AppColor.mainColor,
                                        //                                                         noColor: AppColor
                                        //                                                             .deepLightGrey,
                                        //                                                         noTextColor:
                                        //                                                             AppColor.black,
                                        //                                                         onPressedYes: () async {
                                        //                                                           Navigator.pop(
                                        //                                                               context);
                                        //                                                         },
                                        //                                                         onPressedNo: () {
                                        //                                                           Navigator.pop(
                                        //                                                               context);
                                        //                                                         });
                                        //                                                   },
                                        //                                                   child: Container(
                                        //                                                     padding:
                                        //                                                         EdgeInsets.symmetric(
                                        //                                                             horizontal: 7.spMin,
                                        //                                                             vertical: 5.spMin),
                                        //                                                     decoration: GeneralWidget
                                        //                                                         .decoration(
                                        //                                                             shadow: false,
                                        //                                                             radius: 5,
                                        //                                                             showBorder: true,
                                        //                                                             borderColor: AppColor
                                        //                                                                 .resultSuccess
                                        //                                                                 .withOpacity(
                                        //                                                                     0.5)),
                                        //                                                     child: Row(
                                        //                                                       children: [
                                        //                                                         Icon(
                                        //                                                           AppIcons.accept,
                                        //                                                           color: AppColor
                                        //                                                               .resultSuccess
                                        //                                                               .withOpacity(0.5),
                                        //                                                           size: AppSize
                                        //                                                               .appBarIconsSize,
                                        //                                                         ),
                                        //                                                         SizedBox(
                                        //                                                           width: 5.w,
                                        //                                                         ),
                                        //                                                         AppText(
                                        //                                                           text:
                                        //                                                               AppMessage.accept,
                                        //                                                           fontSize: AppSize
                                        //                                                               .smallSubText,
                                        //                                                           fontWeight:
                                        //                                                               FontWeight.w500,
                                        //                                                         )
                                        //                                                       ],
                                        //                                                     ),
                                        //                                                   ),
                                        //                                                 ),
                                        //                                                 SizedBox(
                                        //                                                   width: 15.w,
                                        //                                                 ),
                                        // //reject============================================================================================================================================================
                                        //                                                 InkWell(
                                        //                                                     onTap: () async {
                                        //                                                       AppDialog.confirmDialog(
                                        //                                                           context: context,
                                        //                                                           title:
                                        //                                                               AppMessage.reject,
                                        //                                                           content: AppMessage
                                        //                                                               .rejectConfirm,
                                        //                                                           yesColor: AppColor
                                        //                                                               .errorColor,
                                        //                                                           noColor: AppColor
                                        //                                                               .deepLightGrey,
                                        //                                                           noTextColor:
                                        //                                                               AppColor.black,
                                        //                                                           onPressedYes:
                                        //                                                               () async {
                                        //                                                             Navigator.pop(
                                        //                                                                 context);
                                        //                                                           },
                                        //                                                           onPressedNo: () {
                                        //                                                             Navigator.pop(
                                        //                                                                 context);
                                        //                                                           });
                                        //                                                     },
                                        //                                                     child: Container(
                                        //                                                       padding:
                                        //                                                           EdgeInsets.symmetric(
                                        //                                                               horizontal:
                                        //                                                                   7.spMin,
                                        //                                                               vertical:
                                        //                                                                   5.spMin),
                                        //                                                       decoration: GeneralWidget
                                        //                                                           .decoration(
                                        //                                                               shadow: false,
                                        //                                                               radius: 5,
                                        //                                                               showBorder: true,
                                        //                                                               borderColor: AppColor
                                        //                                                                   .errorColor
                                        //                                                                   .withOpacity(
                                        //                                                                       0.5)),
                                        //                                                       child: Row(
                                        //                                                         children: [
                                        //                                                           Icon(
                                        //                                                             AppIcons.reject,
                                        //                                                             color: AppColor
                                        //                                                                 .errorColor
                                        //                                                                 .withOpacity(
                                        //                                                                     0.5),
                                        //                                                             size: AppSize
                                        //                                                                 .appBarIconsSize,
                                        //                                                           ),
                                        //                                                           SizedBox(
                                        //                                                             width: 5.w,
                                        //                                                           ),
                                        //                                                           AppText(
                                        //                                                             text: AppMessage
                                        //                                                                 .reject,
                                        //                                                             fontSize: AppSize
                                        //                                                                 .smallSubText,
                                        //                                                             fontWeight:
                                        //                                                                 FontWeight.w500,
                                        //                                                           )
                                        //                                                         ],
                                        //                                                       ),
                                        //                                                     )),
                                        //                                               ],
                                        //                                       )
                                      ),
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