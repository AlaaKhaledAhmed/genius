import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'AppColor.dart';
import 'AppSize.dart';
import 'GeneralWidget.dart';

class AppTextFields extends StatelessWidget {
  final bool? obscureText;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? labelText;
  final int? minLines;
  final int? maxLines;
  final bool? enable;
  final FontWeight? fontWeight;
  final void Function()? onTap;
  final bool? customDesign;
  final Color? fillColor;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final void Function(String)? onChanged;
  final TextAlign? textAlignment;
  final Function(String)? onSubmit;
  final String? helperText;
  final TextDirection? textDirection;
  final double? radius;
  final Color? borderColor;
  final Color? focusedColor;
  final double? labelSize;
  final double? borderThickness;
  final double? width;
  final EdgeInsetsGeometry? contentPadding;
  final double? hintStyleHeight;
  final FocusNode? focusNode;
  const AppTextFields(
      {Key? key,
      required this.validator,
      this.onTap,
      this.inputFormatters,
      this.keyboardType,
      required this.controller,
      required this.labelText,
      this.fontWeight,
      this.obscureText,
      this.minLines,
      this.maxLines,
      this.enable,
      this.customDesign,
      this.fillColor,
      this.suffixIcon,
      this.prefixIcon,
      this.onChanged,
      this.textAlignment,
      this.onSubmit,
      this.helperText,
      this.textDirection,
      this.radius,
      this.borderColor,
      this.labelSize,
      this.focusedColor,
      this.borderThickness,
      this.width,
      this.contentPadding,
      this.hintStyleHeight,
      this.focusNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enable ?? true,
      minLines: minLines ?? 1,
      maxLines: maxLines ?? 1,
      onTap: onTap,
      onChanged: onChanged,
      autocorrect: false,
      enableSuggestions: false,
      obscureText: obscureText ?? false,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      autofocus: false,
      textAlign: textAlignment ?? TextAlign.start,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      controller: controller,
      cursorRadius: Radius.circular(20.r),
      cursorColor: AppColor.subColor,
      onFieldSubmitted: onSubmit,
      textDirection: textDirection,
      focusNode: focusNode,
      decoration: InputDecoration(
          labelStyle: TextStyle(
            fontSize: AppSize.smallSubText,
            fontWeight: FontWeight.normal,
            color: AppColor.textColor,
          ),
          helperText: helperText,
          filled: true,
          errorStyle: TextStyle(
            color: AppColor.errorColor,
            fontSize: AppSize.textFieldsSize,
          ),
          fillColor: fillColor ?? AppColor.white,
          border: GeneralWidget.outlineInBorderStyle(),
          enabledBorder: GeneralWidget.outlineInBorderStyle(),
          disabledBorder: GeneralWidget.outlineInBorderStyle(),
          focusedBorder: GeneralWidget.outlineInBorderStyle(),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius ?? AppSize.radius),
              borderSide: BorderSide(color: AppColor.errorColor, width: 0.5)),
          labelText: labelText,
          contentPadding:
              contentPadding ?? EdgeInsets.all(AppSize.contentPadding),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon),
    );
  }
}
