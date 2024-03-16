import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius/Widget/AppColor.dart';
import 'package:genius/Widget/AppConstants.dart';
import 'package:genius/Widget/AppRoutes.dart';
import 'package:genius/Widget/AppSize.dart';
import 'package:genius/Widget/AppText.dart';
import 'package:genius/Widget/GeneralWidget.dart';
import 'package:pie_chart/pie_chart.dart';
import '../../../Widget/AppBar.dart';
import '../../../Widget/AppMessage.dart';
import '../Projects/ProjectsMain.dart';

class Sections extends StatefulWidget {
  const Sections({super.key});

  @override
  State<Sections> createState() => _SectionsState();
}

class _SectionsState extends State<Sections> {
  Map<String, double> dataMap = {
    "جديد": 30, // Change the values as per your project
    "منجزة": 50,
    "غير منجزة": 20,
  };
  List<Color> colorList = [
    Colors.blue,
    Colors.green,
    Colors.red,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(text: AppMessage.sections),
      body: GeneralWidget.body(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: GeneralWidget.height(context) / 3,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Flexible(
                            child: PieChart(
                              chartRadius: 90.r,

                              dataMap: dataMap,
                              colorList: colorList,
                              chartType: ChartType.disc,
                              legendOptions: LegendOptions(
                                showLegendsInRow: true,
                                legendPosition: LegendPosition.bottom,
                                showLegends: true,
                                legendTextStyle: TextStyle(
                                    fontSize: AppSize.smallSubText - 3.spMin),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.w,
                          ),
                          AppText(
                              text: 'المهام الفردية', fontSize: AppSize.subTextSize)
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 30.w,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Flexible(
                            child: PieChart(
                              chartRadius: 90.r,
                      
                              dataMap: dataMap,
                              colorList: colorList,
                              chartType: ChartType.disc,
                              legendOptions: LegendOptions(
                                showLegendsInRow: true,
                                legendPosition: LegendPosition.bottom,
                                showLegends: true,
                                legendTextStyle: TextStyle(
                                    fontSize: AppSize.smallSubText - 3.spMin),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.w,
                          ),
                          AppText(
                              text: 'المشاريع', fontSize: AppSize.subTextSize)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
//================================================================

              AppText(text: AppMessage.calender, fontSize: AppSize.textSize),
              SizedBox(
                height: 20.h,
              ),
              Container(
                margin: EdgeInsets.only(left: 10.w),
                padding: EdgeInsets.all(10),
                width: double.maxFinite,
                decoration: GeneralWidget.decoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppText(
                      text: 'موعد تسليم المشروع',
                      fontSize: AppSize.smallSubText,
                      fontWeight: FontWeight.bold,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
                      width: double.maxFinite,
                      padding:
                          EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
                      decoration: GeneralWidget.decoration(
                          shadow: false, color: AppColor.mainColor),
                      child: AppText(
                          text: '02-04-2024 10:30 pm',
                          fontSize: AppSize.smallSubText,
                          color: AppColor.white),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
//=====================================================================
              AppText(text: AppMessage.sections, fontSize: AppSize.textSize),
              SizedBox(
                height: 20.h,
              ),

//Sections==================================================================
              SizedBox(
                height: 80.h,
                child: ListView.builder(
                    itemCount: AppConstants.sections.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (c, i) {
                      return InkWell(
                        onTap: () {
                          if (i == 3) {
                            AppRoutes.pushTo(context, ProjectsMain());
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          alignment: AlignmentDirectional.center,
                          height: 50,
                          width: 100.w,
                          decoration: GeneralWidget.decoration(),
                          child: AppText(
                            text: AppConstants.sections[i],
                            fontSize: AppSize.subTextSize,
                            align: TextAlign.center,
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
