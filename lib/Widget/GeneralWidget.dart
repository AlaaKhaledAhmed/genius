import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import 'AppColor.dart';
import 'AppConstants.dart';
import 'AppMessage.dart';
import 'AppSize.dart';
import 'AppSnackBar.dart';
import 'AppText.dart';
import 'ImagePath.dart';
import 'package:permission_handler/permission_handler.dart' as p;
import 'package:location/location.dart';

class GeneralWidget {
  static double height(BuildContext context) =>
      MediaQuery.of(context).size.height;
  static double width(BuildContext context) =>
      MediaQuery.of(context).size.width;
//scroll body===========================================================
  static Widget body(
      {required Widget? child,
      ScrollPhysics? physics,
      bool isHorizontal = false}) {
    return LayoutBuilder(builder: ((context, constraints) {
      return NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification? overscroll) {
          overscroll!.disallowIndicator();
          return true;
        },
        child: SingleChildScrollView(
            scrollDirection: isHorizontal ? Axis.horizontal : Axis.vertical,
            physics: physics ?? ClampingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minWidth: constraints.maxWidth,
                  minHeight: constraints.maxHeight),
              child: IntrinsicHeight(child: child),
            )),
        //)
      );
// AppText(text: LocaleKeys.myTeam.tr(), fontSize: WidgetSize.titleTextSize);
    }));
  }

//borderStyle===============================================================================================
  static outlineInBorderStyle({bool? isFocus}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSize.smallRadius),
      borderSide: BorderSide(
        color: isFocus == true ? AppColor.subColor : AppColor.lightGrey,
        width: AppSize.smallRadius,
      ),
    );
  }

//borderStyle for check drop dawn list===============================================================================================
  static containerBorderStyle({double? radius, Color? borderColor}) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(radius ?? AppSize.smallRadius),
      border: Border.all(
        color: borderColor ?? AppColor.lightGrey,
        width: AppSize.smallRadius,
      ),
      color: AppColor.white,
    );
  }

  //======================random number=======================================
  static String randomNumber(int length) {
    const characters = '0123456789';
    Random random = Random();
    return String.fromCharCodes(Iterable.generate(length,
        (_) => characters.codeUnitAt(random.nextInt(characters.length))));
  }

//==================random upper char=============================================
  static String randomUpper(int length) {
    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    Random random = Random();
    return String.fromCharCodes(Iterable.generate(length,
        (_) => characters.codeUnitAt(random.nextInt(characters.length))));
  }

//==================random lower char=============================================
  static String randomLower(int length) {
    const characters = 'abcdefghijklmnopqrstuvwxyz';
    Random random = Random();
    return String.fromCharCodes(Iterable.generate(length,
        (_) => characters.codeUnitAt(random.nextInt(characters.length))));
  }

//==================random char=============================================
  static String randomCode(int length) {
    const characters = '#%^*_-!';
    Random random = Random();
    return String.fromCharCodes(Iterable.generate(length,
        (_) => characters.codeUnitAt(random.nextInt(characters.length))));
  }

//===================================================================================================================
  static Widget intrinsicWidthListTile({
    required String subtitle,
    required String title,
    IconData? icon,
    bool showCircleAvatar = true,
    bool showShadow = true,
    Color? iconColor,
    Widget? child,
  }) {
    return IntrinsicWidth(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
        boxShadow: showShadow == false
            ? null
            : [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  offset: const Offset(0.0, 1.0),
                  blurRadius: 6.0,
                ),
              ],
      ),
      child: ListTile(
        title: AppText(
          text: title,
          fontSize: AppSize.textSize,
          fontWeight: FontWeight.bold,
        ),
        subtitle: AppText(text: subtitle, fontSize: AppSize.subTextSize),
        leading: showCircleAvatar
            ? CircleAvatar(
                backgroundColor: AppColor.subColor,
                child: child ??
                    Icon(
                      icon!,
                      size: AppSize.iconsSize,
                      color: AppColor.white,
                    ),
              )
            : Icon(
                icon,
                size: AppSize.iconsSize,
                color: iconColor,
              ),
      ),
    ));
  }

//======================================================================================
  static BoxDecoration decoration(
      {bool? shadow,
      bool? radiusOnlyTop,
      bool? radiusOnlyBottom,
      bool? radiusOnlyTopLeftButtomLeft,
      bool? radiusOnlyTopRightButtomRight,
      Color? color,
      double radius = 10,
      bool showBorder = false,
      Color? borderColor,
      double borderWidth = 0.5,
      ImageProvider<Object>? image,
      bool cover = false,
      ColorFilter? colorFilter,
      bool isGradient = false}) {
    return BoxDecoration(
        image: image == null
            ? null
            : DecorationImage(
                image: image,
                fit: cover == true ? BoxFit.cover : BoxFit.contain,
                colorFilter: colorFilter),
        border: showBorder == true
            ? Border.all(
                color: borderColor ?? AppColor.lightGrey, width: borderWidth)
            : null,
        color: isGradient == true ? null : (color ?? AppColor.white),
        borderRadius: radiusOnlyTop == true
            ? BorderRadius.only(
                topRight: Radius.circular(radius.r),
                topLeft: Radius.circular(radius.r),
              )
            : radiusOnlyBottom == true
                ? BorderRadius.only(
                    bottomLeft: Radius.circular(radius.r),
                    bottomRight: Radius.circular(radius.r))
                : radiusOnlyTopLeftButtomLeft == true
                    ? BorderRadius.only(
                        topLeft: Radius.circular(radius.r),
                        bottomLeft: Radius.circular(radius.r),
                      )
                    : radiusOnlyTopRightButtomRight == true
                        ? BorderRadius.only(
                            topRight: Radius.circular(radius.r),
                            bottomRight: Radius.circular(radius.r))
                        : BorderRadius.all(Radius.circular(radius.r)),
        boxShadow: shadow == null
            ? [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  offset: const Offset(0.0, 1.0), //(x,y)
                  blurRadius: 6.0,
                ),
              ]
            : null,
        gradient: isGradient
            ? LinearGradient(colors: [
                AppColor.mainColor,
                AppColor.subColor,
              ])
            : null);
  }

  //==============================================================
  static imageError() {
    return Image.asset(ImagePath.back);
  }

//==============================================================
  static AssetImage placeholderImage({image}) {
    return AssetImage(image ?? ImagePath.back);
  }

  static placeholderCashNetwork({image, fit}) {
    return Image.asset(
      image ?? ImagePath.back,
      fit: fit,
    );
  }

//auto Scroll list============================================================
  static autoScrollListView(
      {required ScrollController scrollController,
      required int listLength,
      required int goToIndex}) {
    final contentSize = scrollController.position.viewportDimension +
        scrollController.position.maxScrollExtent;

    final target = contentSize * goToIndex / listLength;
    scrollController.position.animateTo(target,
        curve: Curves.ease, duration: const Duration(milliseconds: 300));
  }

//=========================================================================
  static Future<void> ensureVisibleOnTextArea({required GlobalKey key}) async {
    final keyContext = key.currentContext;
    if (keyContext != null) {
      await Future.delayed(const Duration(milliseconds: 500)).then(
        (value) => Scrollable.ensureVisible(
          keyContext,
          duration: const Duration(milliseconds: 200),
          curve: Curves.decelerate,
        ),
      );
    }
  }

  //========================================================================
  static Widget closeBox(
      {required BuildContext context,
      Color? color,
      Color? iconColor,
      EdgeInsetsGeometry? margin}) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        decoration: GeneralWidget.decoration(
          color: color ?? AppColor.mainColor,
        ),
        margin: margin,
        width: 40.spMin,
        height: 40.spMin,
        child: Icon(
          Icons.close,
          color: iconColor ?? AppColor.white,
          size: AppSize.appBarIconsSize,
        ),
      ),
    );
  }

  //calender them=============================================================================================
  static them({required BuildContext context, required Widget child}) {
    return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: AppColor.mainColor,
            onPrimary: AppColor.white,
            onBackground: AppColor.subColor,
            primaryContainer: AppColor.mainColor,
            background: AppColor.white,
            // header text color// body text color
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: AppColor.mainColor, // button text color
            ),
          ),
        ),
        child: child);
  }

  ///==================================================================================================
  static Widget emptyData({required BuildContext context, String? lottieFile}) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            lottieFile ?? 'assets/lottie/emptyList.json',
            width: MediaQuery.of(context).size.width - 100,
            fit: BoxFit.contain,
          ),
          SizedBox(
            height: 10.h,
          ),
          Transform.translate(
              offset: Offset(0, -40.h),
              child: AppText(
                  text: AppMessage.noData, fontSize: AppSize.subTextSize))
        ],
      ),
    );
  }

  ///convert date time to string===========================================================================================
  static convertDate(DateTime? dateTime, {bool showTime = true}) {
    return showTime == true
        ? '${dateTime!.hour.toString().padLeft(2, '0')}:'
            '${dateTime.minute.toString().padLeft(2, '0')}'
            ' ${dateTime.year}-'
            '${dateTime.month.toString().padLeft(2, '0')}-'
            '${dateTime.day.toString().padLeft(2, '0')}'
        : '${dateTime?.year}-'
            '${dateTime?.month.toString().padLeft(2, '0')}-'
            '${dateTime?.day.toString().padLeft(2, '0')}';
  }

  //=======================get Current Location======================================
  static Future<String> requestLocationPermission() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return "locationNotEnable";
      }
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted == PermissionStatus.deniedForever) {
        return 'open_setting';
      }
      if (permissionGranted != PermissionStatus.granted) {
        return 'PERMISSION_DENIED';
      }
    }
    // locationData = await location.getLocation();
    return 'granted';
  }

  ///handelLocationResult ==========================================================================
  static int handelLocationResult(BuildContext context, String result) {
    switch (result) {
      case 'locationNotEnable':
        {
          return -1;
        }
      case 'open_setting':
        {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          AppSnackBar.showInSnackBar(
              duration: const Duration(days: 1),
              context: context,
              message:'enableLocation',
              isSuccessful: false,
              showTrailing: true,
              trailingText: 'active',
              onTap: () async {
                await p.openAppSettings().then((value) {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                });
              });

          return -1;
        }

      case 'PERMISSION_DENIED':
        {
          return -1;
        }

      case 'granted':
        {
          return 1;
        }
    }
    return -1;
  }
}
