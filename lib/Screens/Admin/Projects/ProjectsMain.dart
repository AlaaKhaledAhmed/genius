import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius/Screens/Admin/Projects/Tasks/AddTask.dart';
import 'package:genius/Screens/Admin/Projects/Tasks/AdminTask.dart';
import 'package:genius/Screens/Admin/Projects/UpdateProject.dart';
import 'package:scrollable_table_view/scrollable_table_view.dart';

import '../../../BackEnd/Database/DatabaseMethods..dart';
import '../../../Widget/AppBar.dart';
import '../../../Widget/AppButtons.dart';
import '../../../Widget/AppColor.dart';
import '../../../Widget/AppConstants.dart';
import '../../../Widget/AppDialog.dart';
import '../../../Widget/AppIcons.dart';
import '../../../Widget/AppMessage.dart';
import '../../../Widget/AppRoutes.dart';
import '../../../Widget/AppSize.dart';
import '../../../Widget/AppText.dart';
import '../../../Widget/GeneralWidget.dart';
import 'AddProject.dart';
import 'Tasks/UpdateTask.dart';

class ProjectsMain extends StatefulWidget {
  const ProjectsMain({Key? key}) : super(key: key);

  @override
  State<ProjectsMain> createState() => _ProjectsMainState();
}

class _ProjectsMainState extends State<ProjectsMain> {
  List<String> header = [
    AppMessage.projectName,
    AppMessage.projectPrice,
    AppMessage.starDate,
    AppMessage.endDate,
    AppMessage.employNumbers,
    AppMessage.status,
    AppMessage.task,
    AppMessage.action,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        text: AppMessage.projectManagement,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: AppColor.white,
            size: AppSize.iconsSize + 6,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            child: AppButtons(
              onPressed: () {
                AppRoutes.pushTo(context, const AddProject());
              },
              text: AppMessage.addProject,
              icon: AppIcons.add,
            ),
          ),
          Expanded(
              flex: 5,
              child: StreamBuilder(
                stream: AppConstants.projectCollection
                    .orderBy('createdOn', descending: true)
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: AppText(
                        text: AppMessage.serverText,
                        fontSize: AppSize.subTextSize,
                      ),
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
                              headers: header
                                  .map((e) => TableViewHeader(
                                        label: e,
                                        textStyle: TextStyle(
                                          color: AppColor.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        alignment: Alignment.center,
                                        width: 120.w,
                                      ))
                                  .toList(),
                              rows: List.generate(data.length, (index) {
                                // Convert dynamic list to Employee list
                                List<dynamic> employeesData =
                                    data[index].data()['employees'];
                                List<Employee> employees = employeesData
                                    .map((e) => Employee.fromMap(e))
                                    .toList();

                                return TableViewRow(
                                  height: 45.h,
                                  cells: [
// project name ====================================================================
                                    TableViewCell(
                                      alignment: Alignment.center,
                                      child: AppText(
                                        text: '${data[index].data()?['name']}',
                                        fontSize: AppSize.subTextSize,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
// price=========================================================================
                                    TableViewCell(
                                      alignment: Alignment.centerRight,
                                      child: TableViewCell(
                                        alignment: Alignment.center,
                                        child: AppText(
                                          text:
                                              '${data[index].data()['price']} ${AppMessage.RSA}',
                                          fontSize: AppSize.subTextSize,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
// start date========================================================================================================================================
                                    TableViewCell(
                                      alignment: Alignment.centerRight,
                                      child: TableViewCell(
                                        alignment: Alignment.center,
                                        child: AppText(
                                          text:
                                              '${GeneralWidget.convertStringToDate((data[index].data()['startDate']).toDate())}',
                                          fontSize: AppSize.subTextSize,
                                        ),
                                      ),
                                    ),
// end date ========================================================================================================================================
                                    TableViewCell(
                                      alignment: Alignment.centerRight,
                                      child: TableViewCell(
                                        alignment: Alignment.center,
                                        child: AppText(
                                          text:
                                              '${GeneralWidget.convertStringToDate((data[index].data()['endDate']).toDate())}',
                                          fontSize: AppSize.subTextSize,
                                        ),
                                      ),
                                    ),
// number of employees========================================================================================================================================
                                    TableViewCell(
                                      alignment: Alignment.centerRight,
                                      child: TableViewCell(
                                        alignment: Alignment.center,
                                        child: AppText(
                                          text: '${employees.length}',
                                          fontSize: AppSize.subTextSize,
                                        ),
                                      ),
                                    ),
// status========================================================================================================================================
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
// add task========================================================================================================================================
                                    TableViewCell(
                                      alignment: Alignment.centerRight,
                                      child: TableViewCell(
                                        alignment: Alignment.center,
                                        child: IconButton(
                                          onPressed: () {
                                            color_print('id: ${data[index]
                                                .data()['projectId']}');
                                            AppRoutes.pushTo(
                                              context,
                                              AdminTask(
                                                  projectId: data[index]
                                                      .data()['projectId']),
                                            );
                                          },
                                          icon: Icon(
                                            AppIcons.view,
                                            size: AppSize.iconsSize + 10,
                                            color: AppColor.mainColor,
                                          ),
                                        ),
                                      ),
                                    ),
// action========================================================================================================================================
                                    TableViewCell(
                                      alignment: Alignment.center,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
// delete==========================================================================================
                                          IconButton(
                                            onPressed: () {
                                              AppLoading.show(
                                                context,
                                                AppMessage.delete,
                                                AppMessage.confirm,
                                                showButtom: true,
                                                noFunction: () {
                                                  Navigator.pop(context);
                                                },
                                                yesFunction: () async {
                                                  Navigator.pop(context);
                                                  await Database
                                                      .deleteProjectsTask(
                                                          projectId: data[
                                                                      index]
                                                                  .data()[
                                                              'projectId']);
                                                  await Database.delete(
                                                    collection: 'projects',
                                                    docId: snapshot
                                                        .data.docs[index].id,
                                                  );
                                                },
                                              );
                                            },
                                            icon: Icon(
                                              AppIcons.delete,
                                              size: AppSize.iconsSize + 10,
                                              color: AppColor.errorColor,
                                            ),
                                          ),
                                          SizedBox(width: 5.w),
// update==================================================================================================================================
                                          IconButton(
                                            onPressed: () {
                                              AppRoutes.pushTo(
                                                context,
                                                UpdateProject(
                                                  docId: snapshot
                                                      .data.docs[index].id,
                                                  data: data[index].data(),
                                                ),
                                              );
                                            },
                                            icon: Icon(
                                              AppIcons.update,
                                              size: AppSize.iconsSize + 10,
                                              color: AppColor.mainColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            ),
                          );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ))
        ],
      ),
    );
  }
}
