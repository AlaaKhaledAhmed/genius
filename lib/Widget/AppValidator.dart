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

  //valid Phone data============================================================
  static String? validatorPhone(phone) {
    if (phone.trim().isEmpty) {
      return AppMessage.mandatoryTx;
    }

    if (phone.startsWith('0')) {
      return AppMessage.startWithZero;
    }
    if (!phone.startsWith('5')) {
      return AppMessage.startWith5;
    }
    if (phone.length != 9) {
      return AppMessage.noLessThan9;
    }
    return null;
  }

  static String? validatorId(id) {
    if (id.trim().isEmpty) {
      return AppMessage.mandatoryTx;
    }

    if (id.length != 10) {
      return AppMessage.noLessThan10;
    }
    return null;
  }

  static String? validatorNumbers(id) {
    final numberRegExp = RegExp(r'^[0-9]+$');

    if (id.trim().isEmpty) {
      return AppMessage.mandatoryTx;
    }

    if (!numberRegExp.hasMatch(id)) {
      return AppMessage.onlyDigits;
    }
    return null;
  }

  //valid email=============================================================
  static String? validatorEmail(email) {
    if (email.isEmpty) {
      return AppMessage.mandatoryTx;
    }
    if (EmailValidator.validate(email.trim()) == false) {
      return AppMessage.invalidEmail;
    }
    return null;
  }

  //valid name data============================================================
  static String? validatorName(name) {
    if (name == null || name.isEmpty) {
      return AppMessage.mandatoryTx;
    } else {
      if (name.length > 14) {
        return AppMessage.noMoreThan14;
      }
    }
  }
}
