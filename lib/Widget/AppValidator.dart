import 'package:email_validator/email_validator.dart';

import 'AppMessage.dart';

class AppValidator {
//valid empty data============================================================
  static String? validatorEmpty(v) {
    if (v == null || v.isEmpty) {
      return AppMessage.mandatoryTx;
    } else {
      return null;
    }
  }
}
