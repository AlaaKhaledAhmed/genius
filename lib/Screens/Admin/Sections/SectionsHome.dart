import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius/Widget/AppColor.dart';
import 'package:genius/Widget/GeneralWidget.dart';
import 'package:pie_chart/pie_chart.dart';
import '../../../Widget/AppBar.dart';
import '../../../Widget/AppMessage.dart';

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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: GeneralWidget.height(context) / 3,
              child: Row(
                children: [
                  Expanded(
                    child: PieChart(
                      dataMap: dataMap,
                      colorList: colorList,
                      chartType: ChartType.disc,
                      legendOptions: const LegendOptions(
                        showLegendsInRow: true,
                        legendPosition: LegendPosition.bottom,
                        showLegends: true,
                        legendTextStyle: TextStyle(fontSize: 14),
                      ),
                      centerText: 'المهام',
                    ),
                  ),
                  SizedBox(
                    width: 30.w,
                  ),
                  Expanded(
                    child: PieChart(
                      dataMap: dataMap,
                      colorList: colorList,
                      chartType: ChartType.disc,
                      legendOptions: const LegendOptions(
                        showLegendsInRow: true,
                        legendPosition: LegendPosition.bottom,
                        showLegends: true,
                        legendTextStyle: TextStyle(fontSize: 14),
                      ),
                      centerText: 'المشاريع',
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
