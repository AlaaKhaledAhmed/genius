import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomError extends StatelessWidget {
  final FlutterErrorDetails errorDetails;

  const CustomError({
    Key? key,
    required this.errorDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: LayoutBuilder(builder: (context, constraints) {
          return NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification? overscroll) {
              overscroll!.disallowIndicator();
              return true;
            },
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    minWidth: constraints.maxWidth,
                    minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // SvgPicture.asset(
                      //   'assets/Svg/error.svg',
                      //   semanticsLabel: 'Acme Logo',
                      //   height: 70.h,
                      //   width: 70.w,
                      // ),
                      // SizedBox(height: 10.h,),
                      Text(
                        kDebugMode
                            ? errorDetails.summary.toString()
                            : 'عفوًا! حدث خطأ ما!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: kDebugMode ? Colors.red : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 17.sm),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        kDebugMode
                            ? 'https://docs.flutter.dev/testing/errors'
                            : errorDetails.summary.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 14.sm),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
