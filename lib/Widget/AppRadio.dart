import 'package:flutter/material.dart';
import 'AppColor.dart';
import 'AppSize.dart';
import 'AppText.dart';

class AppRadio extends StatelessWidget {
  final String labelName;
  final int groupValue;
  final int value;
  final Color? textColor;
  final void Function(int?)? onChanged;
  const AppRadio(
      {Key? key,
      required this.labelName,
      required this.groupValue,
      required this.value,
      this.onChanged,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            fillColor:
                MaterialStateColor.resolveWith((states) => AppColor.subColor),
            value: value,
            groupValue: groupValue,
            onChanged: onChanged),
        AppText(
          text: labelName,
          fontSize: AppSize.textSize,
          color: textColor,
        )
      ],
    );
  }
}
