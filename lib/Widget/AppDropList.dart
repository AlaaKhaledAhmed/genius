import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'AppColor.dart';
import 'AppIcons.dart';
import 'AppSize.dart';
import 'AppText.dart';
import 'GeneralWidget.dart';

class AppDropList extends StatelessWidget {
  final List<String> listItem;
  final String? Function(String?)? validator;
  final String? hintText;
  // final String? dropValue;
  final bool? friezeText;
  final Color? fillColor;
  final Widget? prefixIcon;
  final Widget?icon;
  final void Function(String?)? onChanged;
  const AppDropList(
      {Key? key,
      required this.listItem,
      required this.validator,
      required this.hintText,
      required this.onChanged,
      // required this.dropValue,
      this.friezeText,
      this.fillColor,
      this.prefixIcon, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<String>(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      dropdownMaxHeight: 200.h,
      scrollbarAlwaysShow: true,
      alignment: Alignment.centerRight,
      // value: dropValue,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(AppSize.contentPadding),
        labelStyle: TextStyle(
          fontSize: AppSize.smallSubText,
          fontWeight: FontWeight.normal,
          color: AppColor.textColor,
          fontFamily: GoogleFonts.tajawal().fontFamily,
        ),
        errorStyle: TextStyle(
          color: AppColor.errorColor,
          fontSize: AppSize.smallSubText,
          fontFamily: GoogleFonts.tajawal().fontFamily,
        ),
        labelText: hintText,
        filled: true,
        fillColor: fillColor ?? AppColor.white,
        border: GeneralWidget.outlineInBorderStyle(),
        focusedBorder: GeneralWidget.outlineInBorderStyle(isFocus: true),
        enabledBorder: GeneralWidget.outlineInBorderStyle(),
      ),
      dropdownDecoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.all(Radius.circular(AppSize.radius))),
      onChanged: onChanged,
      iconDisabledColor: AppColor.highlightColor,
      iconEnabledColor: AppColor.highlightColor,
      icon: icon,
      itemPadding: EdgeInsets.zero,
      items: listItem
          .map((item) => DropdownMenuItem(

                alignment: AlignmentDirectional.center,
                value: item,
                child: AppText(
                  fontSize: AppSize.textFieldsSize,
                  text: item,
                  color: AppColor.textColor,
                ),
              ))
          .toList(),
    );
  }
}
