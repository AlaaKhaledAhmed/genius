import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'AppColor.dart';
import 'AppSize.dart';
import 'AppText.dart';

class AppButtons extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final Color? backgroundColor;
  final Color? textStyleColor;
  final FontWeight? textStyleWeight;
  final TextOverflow? overflow;
  final double? elevation;
  final double? width;
  final double? height;
  final IconData? icon;
  final double? textSize;
  final double? radius;
  final AlignmentGeometry? alignment;
  const AppButtons(
      {Key? key,
      required this.onPressed,
      required this.text,
      this.backgroundColor,
      this.overflow,
      this.textStyleColor,
      this.textStyleWeight,
      this.width,
      this.elevation,
      this.height,
      this.icon,
      this.textSize,
      this.radius,
      this.alignment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? 45.h,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          alignment: alignment??AlignmentDirectional.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? AppSize.radius),
          ),
          backgroundColor: backgroundColor ?? AppColor.mainColor,
          elevation: elevation ?? 1.0,
          textStyle: TextStyle(

              fontFamily: GoogleFonts.tajawal().fontFamily,
              color: textStyleColor ?? AppColor.textColor,
              fontSize: AppSize.buttonSize,
              fontStyle: FontStyle.normal),
        ),
        onPressed: onPressed,
        icon: icon != null
            ? Icon(
                icon,
                size: AppSize.iconsSize,
                color: AppColor.white,

              )
            : Icon(
                icon,
                size: 0,
                color: AppColor.white,
              ),
        label: AppText(
            fontSize: textSize ?? AppSize.buttonSize,
            text: text,
            align: TextAlign.center,
            color: textStyleColor ?? AppColor.white,
            fontWeight: textStyleWeight ?? FontWeight.normal,
            fontFamily: GoogleFonts.tajawal().fontFamily),
      ),
    );
  }
}
