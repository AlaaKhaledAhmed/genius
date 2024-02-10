import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'AppColor.dart';

class AppPopUpMen extends StatelessWidget {
  final List<PopupMenuEntry> menuList;
  final Widget? icon;
  //final Color? color;
  final PopupMenuPosition? position;
  final BoxConstraints? constraints;
  final EdgeInsetsGeometry? padding;
  const AppPopUpMen(
      {Key? key,
      required this.menuList,
      this.icon,
      this.constraints,
      this.position,
      this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        surfaceTintColor: AppColor.white,
        color: AppColor.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0.spMin),
        ),
        icon: icon,
        padding: padding ?? EdgeInsets.zero,
        position: position,
        itemBuilder: ((context) => menuList),
        constraints: constraints);
  }
}
