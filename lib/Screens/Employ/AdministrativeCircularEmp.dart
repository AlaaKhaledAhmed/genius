import 'package:flutter/material.dart';

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
import 'package:url_launcher/url_launcher.dart';

import '../../../Widget/AppSize.dart';
import '../../../Widget/AppText.dart';
import '../../../Widget/GeneralWidget.dart';
import '../Admin/PDFView.dart';

class AdministrativeCircularEmp extends StatefulWidget {
  const AdministrativeCircularEmp({Key? key}) : super(key: key);

  @override
  State<AdministrativeCircularEmp> createState() =>
      _AdministrativeCircularState();
}

class _AdministrativeCircularState extends State<AdministrativeCircularEmp> {
  List<String> header = [
    AppMessage.title,
    AppMessage.text,
    AppMessage.file,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        text: AppMessage.administrativeCircular,
        isEmp: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h,
            ),
            Expanded(
                flex: 5,
                child: StreamBuilder(
                  stream: AppConstants.administrativeCircularCollection
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
                          : ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (c, index) {
                                return Container(
                                  decoration: GeneralWidget.decoration(),
                                  child: ListTile(
                                    title: AppText(
                                      text: '${data[index].data()?['title']}',
                                      fontSize: AppSize.subTextSize,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.subColor,
                                    ),
                                    subtitle: AppText(
                                      text: '${data[index].data()?['text']}',
                                      fontSize: AppSize.subTextSize,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    trailing: IconButton(
                                      onPressed: data[index]
                                              .data()?['file']
                                              .isEmpty
                                          ? () {
                                              AppLoading.show(
                                                  context,
                                                  AppMessage
                                                      .administrativeCircular,
                                                  AppMessage
                                                      .noFile);
                                            }
                                          : () async {
                                              //open file
                                              ///open pdf view
                                              showGeneralDialog(
                                                context: context,
                                                pageBuilder: (
                                                  BuildContext context,
                                                  Animation<double> animation,
                                                  Animation<double>
                                                      secondaryAnimation,
                                                ) {
                                                  return PDFViewerPage(
                                                    pdfUrl: data[index]
                                                        .data()?['file'],
                                                    titleName: AppMessage
                                                        .administrativeCircular,
                                                  );
                                                },
                                              );
                                            },
                                      icon: Icon(AppIcons.view),
                                    ),
                                  ),
                                );
                              });

//                       MediaQuery.removePadding(
//                               removeBottom: true,
//                               context: context,
//                               child: ScrollableTableView(
//                                 rowDividerHeight: 0.5.spMin,
//                                 headerHeight: 40.h,
//                                 headerBackgroundColor: AppColor.deepLightGrey,
// //headers======================================================================================================================================================
//                                 headers: header
//                                     .map((e) => TableViewHeader(
//                                           label: e,
//                                           textStyle: TextStyle(
//                                               color: AppColor.black,
//                                               fontWeight: FontWeight.normal),
//                                           alignment: Alignment.center,
//                                           width: 120.w,
//                                         ))
//                                     .toList(),
//                                 rows: List.generate(data.length, (index) {
//                                   return TableViewRow(
//                                     height: 45.h,
//                                     cells: [
// //title======================================================================================================================================================
//                                       TableViewCell(
//                                           alignment: Alignment.center,
//                                           child: AppText(
//                                             text:
//                                                 '${data[index].data()?['title']}',
//                                             fontSize: AppSize.subTextSize,
//                                             overflow: TextOverflow.ellipsis,
//                                           )),
//
// //text======================================================================================================================================================
//                                       TableViewCell(
//                                           alignment: Alignment.center,
//                                           child: AppText(
//                                             text:
//                                                 '${data[index].data()?['text']}',
//                                             fontSize: AppSize.subTextSize,
//                                             overflow: TextOverflow.ellipsis,
//                                           )),
//
// //file======================================================================================================================================================
//                                       TableViewCell(
//                                           alignment: Alignment.center,
//                                           child: data[index]
//                                                   .data()?['file']
//                                                   .isEmpty
//                                               ? const Text('-')
//                                               :
//                                               IconButton(
//                                                   onPressed: () async {
//                                                     //open file
//                                                     ///open pdf view
//                                                     showGeneralDialog(
//                                                       context: context,
//                                                       pageBuilder: (
//                                                         BuildContext context,
//                                                         Animation<double>
//                                                             animation,
//                                                         Animation<double>
//                                                             secondaryAnimation,
//                                                       ) {
//                                                         return PDFViewerPage(
//                                                           pdfUrl: data[index]
//                                                               .data()?['file'],
//                                                           titleName: AppMessage
//                                                               .administrativeCircular,
//                                                         );
//                                                       },
//                                                     );
//                                                   },
//                                                   icon: Icon(
//                                                     AppIcons.file,
//                                                     color: Colors.black
//                                                         .withOpacity(0.16),
//                                                     size:
//                                                         AppSize.iconsSize + 10,
//                                                   ))),
//                                     ],
//                                   );
//                                 }),
//                               ));
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
