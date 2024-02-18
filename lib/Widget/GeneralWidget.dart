import 'dart:math';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'AppColor.dart';
import 'AppIcons.dart';
import 'AppMessage.dart';
import 'AppPath.dart';
import 'AppSize.dart';
import 'AppSvg.dart';
import 'AppText.dart';

typedef RefreshUi = VoidCallback;

class GeneralWidget {
  static double width(context) => MediaQuery.of(context).size.width;
  static double height(context) => MediaQuery.of(context).size.height;
//scroll body===========================================================
  static Widget body({required Widget? child, ScrollPhysics? physics}) {
    return LayoutBuilder(builder: ((context, constraints) {
      return NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification? overscroll) {
          overscroll!.disallowIndicator();
          return true;
        },
        child: SingleChildScrollView(
            physics: physics ?? const ClampingScrollPhysics(),
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

  //=========================text span ========================

  static TextSpan textSpan(
      {text, textColor, double? textSize, onTap, children, fontWeight}) {
    return TextSpan(
        recognizer: TapGestureRecognizer()..onTap = onTap,
        text: text,
        children: children,
        style: TextStyle(
          height: 1.25.h,
          color: textColor,
          fontSize: textSize,
          fontWeight: fontWeight,
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
                color: borderColor ?? AppColor.deepLightGrey,
                width: borderWidth)
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
        boxShadow: shadow == null || shadow == false
            ? [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 4,
                  blurRadius: 4,
                  offset: const Offset(0, 0),
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
    return Image.asset(AppPath.logo);
  }

//==============================================================
  static AssetImage placeholderImage({image}) {
    return AssetImage(image ?? AppPath.logo);
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
          AppSvg(
            path: AppPath.empty,
            height: 200.h,
          ),
          SizedBox(
            height: 50.h,
          ),
          Transform.translate(
              offset: Offset(0, -40.h),
              child:
                  AppText(text: AppMessage.noData, fontSize: AppSize.labelSize))
        ],
      ),
    );
  }

  ///===============================================================================
  static Future<List<DateTime?>?> showDateRangDialog(
      {required BuildContext context, DateTime? startDate}) async {
    List<DateTime?>? results = await showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(
        currentDate: DateTime.now(),
        firstDate: startDate,
        calendarType: CalendarDatePicker2Type.range,
        selectedDayTextStyle:
            TextStyle(color: AppColor.white, fontWeight: FontWeight.w700),
        selectedDayHighlightColor: AppColor.mainColor,
        centerAlignModePicker: true,
        cancelButton: AppText(
          text: 'الغاء',
          fontSize: AppSize.labelSize,
          color: AppColor.mainColor,
        ),
        okButton: AppText(
          text: 'تأكيد',
          fontSize: AppSize.labelSize,
          color: AppColor.mainColor,
        ),
      ),
      dialogSize: Size(325.w, 400.h),
      borderRadius: BorderRadius.circular(15.r),
    );
    return results;
  }

  ///convert date to string===========================================================================================
  static convertStringToDate(DateTime? dateTime) {
    return '${dateTime?.day.toString().padLeft(2, '0')} '
        '${convertMonth(dateTime!.month)} '
        '${dateTime.year}';
  }

  ///convert date and time to string===========================================================================================
  static convertStringToDateAndTime(DateTime? dateTime) {
    return '${dateTime!.hour.toString().padLeft(2, '0')}:'
        '${dateTime.minute.toString().padLeft(2, '0')}'
        ' ${dateTime.year}-'
        '${convertMonth(dateTime.month)}-'
        '${dateTime.day.toString().padLeft(2, '0')}';
  }

  static String convertMonth(int month) {
    switch (month) {
      case 1:
        return 'يناير';
      case 2:
        return 'فبراير';
      case 3:
        return 'مارس';
      case 4:
        return 'أبريل';
      case 5:
        return 'مايو';
      case 6:
        return 'يونيو';
      case 7:
        return 'يوليو';
      case 8:
        return 'أغسطس';
      case 9:
        return 'سبتمبر';
      case 10:
        return 'أكتوبر';
      case 11:
        return 'نوفمبر';
      default:
        return 'ديسمبر';
    }
  }

  ///==========================================================================
  static void getSelectedValues(
      {required bool isSelect,
      required dynamic item,
      required List list,
      required RefreshUi refreshUi}) {
    if (isSelect == true) {
      list.add(item);
      refreshUi();
    } else {
      list.remove(item);
      refreshUi();
    }
  }

  ///========================================
  static backgroundImage({
    required String image,
    bool isNetworkImage = true,
    double? height,
    double? width,
  }) {
    return FadeInImage(
      height: height ?? 190.h,
      width: width ?? double.infinity,
      image: isNetworkImage
          ? NetworkImage(image)
          : AssetImage(image) as ImageProvider,
      placeholderFit: BoxFit.cover,
      placeholder: GeneralWidget.placeholderImage(),
      imageErrorBuilder: (context, error, stackTrace) =>
          GeneralWidget.imageError(),
      fit: BoxFit.contain,
    ).image;
  }


  /// ==============================================================================================================================================================
}
