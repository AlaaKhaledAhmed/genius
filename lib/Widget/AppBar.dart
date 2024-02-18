import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../BackEnd/provider_class.dart';
import 'AppColor.dart';
import 'AppIcons.dart';
import 'AppSize.dart';
import 'AppText.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final Widget? leading;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final double? elevation;
  final bool? isBasics;
  const AppBarWidget(
      {Key? key,
      required this.text,
      this.leading,
      this.actions,
      this.backgroundColor,
      this.elevation,
      this.isBasics})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(

        ///stop leading ico generate
        automaticallyImplyLeading: false,
        centerTitle: true,
        surfaceTintColor: AppColor.white,
        backgroundColor: isBasics == true
            ? AppColor.noColor
            : (backgroundColor ?? AppColor.mainColor),
        title: AppText(
          text: text,
          fontSize: AppSize.labelSize,
          color: AppColor.white,
        ),
        //-----------------------------------------------------------------------------------
        leading: leading ??
            IconButton(
              icon: Icon(
                Icons.menu,
                color: AppColor.white,
              ),
              onPressed: context.read<ProviderClass>().controlMenu,
            ),
        //-----------------------------------------------------------------------------------
        actions: isBasics == true
            ? [
                IconButton(
                  icon: Icon(
                    AppIcons.back,
                    color: AppColor.mainColor,
                    size: AppSize.appBarIconsSize + 5,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ]
            : actions

        // centerTitle: true,
        );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
