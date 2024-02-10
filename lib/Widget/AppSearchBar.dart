import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'AppColor.dart';
import 'AppSize.dart';
import 'AppText.dart';
import 'GeneralWidget.dart';

class AppSearchBar extends StatelessWidget {
  final String? text;
  const AppSearchBar({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.centerStart,
      padding: EdgeInsets.all(10.spMin),
      width: 200.spMin,
      height: 50.spMin,
      decoration: GeneralWidget.decoration(
          shadow: false,
          color: AppColor.inputBG,
          radius: 5,
          borderColor: AppColor.mainColor,
          showBorder: true),
      child: AppText(
        text: text ?? 'البحث',
        fontSize: AppSize.smallSubText - 2,
        color: AppColor.textColor,
      ),
    );
  }
}
