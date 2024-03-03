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
import '../PDFView.dart';
import 'AddAdministrativeCircular.dart';
import 'UpdateAdministrativeCircular.dart';

class AdministrativeCircular extends StatefulWidget {
  const AdministrativeCircular({Key? key}) : super(key: key);

  @override
  State<AdministrativeCircular> createState() => _AdministrativeCircularState();
}

class _AdministrativeCircularState extends State<AdministrativeCircular> {
  List<String> header = [
    AppMessage.title,
    AppMessage.text,
    AppMessage.file,
    AppMessage.action,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        text: AppMessage.administrativeCircular,
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
                  AppRoutes.pushTo(context, const AddAdministrativeCircular());
                },
                text: AppMessage.addAdministrativeCircular,
                icon: AppIcons.add,
              ),
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

//file======================================================================================================================================================
                                      TableViewCell(
                                          alignment: Alignment.center,
                                          child: data[index]
                                                  .data()?['file']
                                                  .isEmpty
                                              ? const Text('-')
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
                                                    size:
                                                        AppSize.iconsSize + 10,
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
                                                          collection:
                                                              'administrativeCircular',
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
                                                    AppRoutes.pushTo(
                                                        context,
                                                        UpdateAdministrativeCircular(
                                                            docId: snapshot.data
                                                                .docs[index].id,
                                                            data: data[index]
                                                                .data()));
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
