 import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

import 'AppSize.dart';


class AppSvg extends StatelessWidget {
  final String path;
  final double? height;
  final double? width;
  final Color? color;
  const AppSvg(
      {required this.path, super.key, this.height, this.width, this.color});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      color: color,
      width: width??AppSize.appBarIconsSize,
      height: height??AppSize.appBarIconsSize,
    );
  }
}
