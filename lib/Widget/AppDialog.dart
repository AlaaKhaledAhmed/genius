import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius/Widget/AppMessage.dart';
import 'package:lottie/lottie.dart';

import 'AppButtons.dart';
import 'AppColor.dart';
import 'AppSize.dart';
import 'AppText.dart';

class AppLoading {
  static show(context, String title, String content,
      {bool showButtom = false,
      void Function()? yesFunction,
      void Function()? noFunction,
      Widget? customContin,
      double? higth}) {
    return showDialog(
        //barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.r))),
            titlePadding: EdgeInsets.zero,
            elevation: 0,

            backgroundColor:
                content == "lode" ? Colors.transparent : AppColor.white,

//tittle-------------------------------------------------------------------

            title: content != "lode"
                ? Container(
                    decoration: BoxDecoration(
                        color: AppColor.mainColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.r),
                            topRight: Radius.circular(10.r))),
                    width: double.infinity,
                    height: 40.h,
                    child: Center(
                      child: AppText(
                        fontSize: AppSize.subTextSize,
                        fontWeight: FontWeight.bold,
                        text: title,
                        color: AppColor.white,
                      ),
                    ),
                  )
                : const SizedBox(),
//continent area-------------------------------------------------------------------

            content: content != "lode"
                ? SizedBox(
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 10.h),
//continent tittle-------------------------------------------------------------------
                      Flexible(
                        flex: 5,
                        child: AppText(
                          fontSize: AppSize.subTextSize,
                          text: content,
                          color: AppColor.black,
                          align: TextAlign.center,
                        ),
                      ),

//divider-------------------------------------------------------------------

                      showButtom
                          ? Divider(
                              thickness: 1,
                              color: AppColor.subColor,
                            )
                          : const SizedBox(),
                      SizedBox(height: 10.h),
//bottoms-------------------------------------------------------------------

                      showButtom
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                  // yes bottoms-------------------------------------------------------------------
                                  Expanded(
                                      child: AppButtons(
                                    height: 30.h,
                                    onPressed: yesFunction,
                                    text: AppMessage.yes,
                                    backgroundColor: AppColor.subColor,
                                  )),

                                  SizedBox(width: 20.w),
                                  //no button-------------------------------------------------------------------
                                  Expanded(
                                    child: AppButtons(
                                      height: 30.h,
                                      onPressed: noFunction,
                                      text: AppMessage.no,
                                      backgroundColor: AppColor.subColor,
                                    ),
                                  )
                                ])
                          : const SizedBox(),
                    ],
                  ))
//Show Waiting image-------------------------------------------------------
                : SizedBox(
                    width: double.infinity,
                    height: 200.h,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Lottie.asset(
                        "assets/lottie/lode.json",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

//Show bottoms -------------------------------------------------------

            actions: [
              showButtom == false && content != "lode"
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.clear,
                                color: AppColor.black,
                                size: AppSize.iconsSize)),
                      ),
                    )
                  : const SizedBox()
            ],
          );
        });
  }
}
