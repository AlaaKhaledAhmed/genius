import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'AppColor.dart';
import 'AppIcons.dart';
import 'AppSize.dart';
import 'AppText.dart';

class AppSnackBar extends StatelessWidget {
  const AppSnackBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }

  static showInSnackBar(
      {required context,
        required String message,
        required bool isSuccessful,
        void Function()? onTap,
        bool showTrailing = false,
        String? trailingText,
        Duration? duration}) {
    var snackBar = SnackBar(
      content: SizedBox(
        child: IntrinsicWidth(
          child: ListTile(
            onTap: onTap,
            contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
            leading: Icon(
              AppIcons.map,
              size: AppSize.iconsSize,
              color: AppColor.white,
            ),
            title: AppText(
              text: message,
              fontSize: AppSize.subTextSize,
              color: AppColor.white,
              fontWeight: FontWeight.bold,
            ),
            trailing: showTrailing == false
                ? const SizedBox(
              height: 0,
              width: 0,
            )
                : AppText(
              text: trailingText!,
              fontSize: AppSize.subTextSize,
              color: AppColor.white,
            ),
          ),
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 130.h,
          right: 20.w,
          left: 20.w),
      backgroundColor:
      isSuccessful ? AppColor.successColor : AppColor.errorColor,
      elevation: 20,
      duration: duration ?? const Duration(seconds: 6),
    );
    // Step 3
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
