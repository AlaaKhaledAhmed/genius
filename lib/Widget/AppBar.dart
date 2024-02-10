import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'AppColor.dart';
import 'AppIcons.dart';
import 'AppSize.dart';
import 'AppText.dart';

import 'package:flutter/material.dart';

import 'GeneralWidget.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final Widget? leading;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final double? elevation;
  const AppBarWidget({
    Key? key,
    required this.text,
    this.leading,
    this.actions,
    this.backgroundColor,
    this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation ?? 0.0,
      child: AppBar(

          ///stop leading ico generate
          //automaticallyImplyLeading: false,
          centerTitle: true,
          surfaceTintColor: AppColor.white,
          backgroundColor: backgroundColor ?? AppColor.mainColor,
          title: AppText(
            text: text,
            fontSize: AppSize.appBarIconsSize,
            color: AppColor.white,
          ),
//-----------------------------------------------------------------------------------
          leading: leading,
//-----------------------------------------------------------------------------------
          actions: actions

          // centerTitle: true,
          ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
