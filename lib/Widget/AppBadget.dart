
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'AppColor.dart';
import 'AppSize.dart';
import 'AppText.dart';


class AppBadge extends StatelessWidget {
  final Widget child;
  final bool showBadge;
  final int badgeCount;
  const AppBadge(
      {Key? key,
      required this.child,
      required this.showBadge,
      required this.badgeCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      showBadge: showBadge,
      position: badges.BadgePosition.topEnd(
          top: badgeCount <= 9 ? -13.spMin : -10.spMin, end: 11.spMin),
      badgeContent: AppText(
        text: badgeCount >= 100 ? '99+' : badgeCount.toString(),
        fontSize: AppSize.smallSubText,
        color: AppColor.subColor,
      ),
      badgeStyle: badges.BadgeStyle(
          badgeColor: AppColor.successColor,
          shape: badgeCount >= 100
              ? badges.BadgeShape.square
              : badges.BadgeShape.circle,
          borderRadius: badgeCount >= 100
              ? BorderRadius.circular(12.spMin)
              : BorderRadius.circular(0.spMin),
          padding: badgeCount >= 100
              ? EdgeInsets.only(left: 5.spMin, right: 5.spMin)
              : EdgeInsets.all(badgeCount > 9 ? 4.spMin : 7.spMin)),
      child: child,
    );
  }
}
