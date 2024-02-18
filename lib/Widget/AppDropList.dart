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
  final String? dropValue;
  final bool? friezeText;
  final Color? fillColor;
  final Widget? prefixIcon;
  final void Function(String?)? onChanged;
  const AppDropList(
      {Key? key,
      required this.listItem,
      required this.validator,
      required this.hintText,
      required this.onChanged,
      required this.dropValue,
      this.friezeText,
      this.fillColor,
      this.prefixIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<String>(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      dropdownMaxHeight: 200.h,
      scrollbarAlwaysShow: true,
      alignment: Alignment.centerRight,
      value: dropValue,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(AppSize.contentPadding),
        hintStyle: TextStyle(
          fontSize: AppSize.smallSubText,
          fontWeight: FontWeight.normal,
          color: AppColor.textColor,
          fontFamily: GoogleFonts.tajawal().fontFamily,
        ),
        hintText: hintText,
        filled: true,
        fillColor: fillColor ?? AppColor.white,
        border: GeneralWidget.outlineInBorderStyle(),
        focusedBorder: GeneralWidget.outlineInBorderStyle(isFocus: true),
        enabledBorder: GeneralWidget.outlineInBorderStyle(),
      ),
      dropdownDecoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.all(Radius.circular(AppSize.radius))),
      onChanged: friezeText == true ? null : onChanged,
      iconDisabledColor: AppColor.highlightColor,
      iconEnabledColor: AppColor.highlightColor,
      items: listItem
          .map((item) => DropdownMenuItem(
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
