import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      icon: Icon(
        AppIcons.arrowDawn,
        size: AppSize.iconsSize,
        color: AppColor.textColor,
      ),
      decoration: InputDecoration(
          filled: true,
          fillColor: fillColor ?? AppColor.white,
          border: GeneralWidget.outlineInBorderStyle(),
          focusedBorder: GeneralWidget.outlineInBorderStyle(isFocus: true),
          enabledBorder: GeneralWidget.outlineInBorderStyle(),
          contentPadding: EdgeInsets.only(bottom: 13.h, left: 0.w)),
      dropdownDecoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.all(Radius.circular(AppSize.radius))),
      onChanged: friezeText == true ? null : onChanged,
      iconDisabledColor: AppColor.highlightColor,
      iconEnabledColor: AppColor.highlightColor,
      buttonWidth: 10,
      buttonPadding: EdgeInsets.only(left: 14.w, right: 14.w),
      hint: prefixIcon != null
          ? Row(
              children: [
                prefixIcon!,
                SizedBox(
                  width: 10.w,
                ),
                AppText(
                  fontSize: AppSize.textFieldsSize,
                  text: hintText ?? '',
                  color: AppColor.textColor,
                )
              ],
            )
          : AppText(
              fontSize: AppSize.textFieldsSize,
              text: hintText ?? '',
              color: AppColor.textColor,
            ),
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
