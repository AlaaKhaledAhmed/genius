import 'package:flutter/material.dart';

import 'CustomError.dart';
class ErrorWidgetClass extends StatelessWidget {
  final FlutterErrorDetails errorDetails;
  const ErrorWidgetClass(this.errorDetails, {super.key});
  @override
  Widget build(BuildContext context) {
    return CustomError(
      errorDetails: errorDetails,
    );
  }
}