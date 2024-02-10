
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'AppMessage.dart';
import 'AppSize.dart';
import 'AppText.dart';
import 'SvgPath.dart';


class HandleException extends StatefulWidget {
  final message;
  final Widget? child;

  const HandleException({super.key, this.message, this.child});

  @override
  State<HandleException> createState() => _HandleExceptionState();

  static getMessage(message, {bool showScaffold = false}) {
    if (message == AppMessage.serverExceptions) {
      return AppMessage.serverText;
    } else if (message == AppMessage.socketException) {
      return AppMessage.socketText;
    } else if (message == AppMessage.timeoutException) {
      return AppMessage.timeoutText;
    } else if (message == AppMessage.formatException) {
      return AppMessage.formatText;
    }else if (message == AppMessage.unAuthorized) {
      return AppMessage.unAuthorizedText;
    }
    return message;
  }
}

class _HandleExceptionState extends State<HandleException>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AspectRatio(
                aspectRatio: 3 / 2,
                child: SvgPicture.asset(SvgPath.apiError),
              ),
              AppText(
                text: HandleException.getMessage(widget.message),
                fontSize: AppSize.subTextSize,
                align: TextAlign.center,
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 65.w),
                child: widget.child,
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
//=========================================================================
}
