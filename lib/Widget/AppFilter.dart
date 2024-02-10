import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'AppColor.dart';
import 'AppSize.dart';
import 'AppSvg.dart';
import 'AppText.dart';
import 'GeneralWidget.dart';
import 'SvgPath.dart';

class AppFilter extends StatelessWidget {
  const AppFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.center,
      width: 50.spMin,
      height: 50.spMin,
      decoration: GeneralWidget.decoration(
          shadow: false,
          color: AppColor.mainColor,
          radius: 5,
          borderColor: AppColor.mainColor,
          showBorder: true),
      child: Center(
        child: AppSvg(
          height: 20.spMin,
          path: SvgPath.filter,
          color: AppColor.white,
        ),
      ),
    );
  }
}
