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

  //valid userName data============================================================
  static String? validatorUserName(name) {
    final regExp = RegExp(r"[a-zA-Z@.-/#]");
    if (name.isEmpty) {
      return AppMessage.mandatoryTx;
    } else if (regExp.hasMatch(name) == false) {
      return AppMessage.englishOnlyValidation;
    } else if (name.length < 4) {
      return AppMessage.noLessThan4;
    } else {
      return null;
    }
  }

//valid name data============================================================
  static String? validatorName(name) {
    String pattern = r'^[\u0621-\u064A\040]+$';
    RegExp regExp = RegExp(pattern);
    if (name == null || name.isEmpty) {
      return AppMessage.mandatoryTx;
    } else {
      // if (regExp.hasMatch(name) == false) {
      //   return AppMessage.arabicOnlyValidation;
      // }
      if (name.length > 14) {
        return AppMessage.noMoreThan14;
      }
    }
  }

  //valid full name data============================================================
  static String? validatorFullName(name) {
    String pattern = r'^[\u0621-\u064A\040]+$';
    RegExp regExp = RegExp(pattern);
    if (name == null || name.isEmpty) {
      return AppMessage.mandatoryTx;
    } else if (regExp.hasMatch(name) == false) {
      return AppMessage.arabicOnlyValidation;
    } else {
      if (name.split(' ').length < 3 || name.endsWith(' ')) {
        return AppMessage.pleaseEnterFullName;
      }
    }
  }

//valid length data============================================================
  static String? validatorLength(v, length) {
    if (v.isEmpty) {
      return AppMessage.mandatoryTx;
    }
    if (v.length > length) {
      return 'الحد الاقصى المسموح به هو $length خانات';
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

//valid Password data============================================================
  static String? validatorPassword(pass) {
    print(pass);
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[-_!%*&^$#?@]).{0,}$';
    RegExp regExp = RegExp(pattern);

    if (pass.isEmpty) {
      return AppMessage.mandatoryTx;
    }
    // else if (regExp.hasMatch(pass) == false) {
    //   return AppMessage.passwordValidation;
    // }
    else if (pass.length < 8) {
      return AppMessage.invalidPassword;
    } else {
      return null;
    }
  }

  //valid Password data============================================================
  static String? validatorConfirmPassword(confirmPassword, password) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[-_!%*&^$#?@]).{0,}$';
    RegExp regExp = RegExp(pattern);

    if (confirmPassword.isEmpty) {
      return AppMessage.mandatoryTx;
    }
    // else if (regExp.hasMatch(confirmPassword) == false) {
    //   return AppMessage.passwordValidation;
    // }
    else if (confirmPassword.length < 8) {
      return AppMessage.invalidPassword;
    } else if (confirmPassword != password) {
      return AppMessage.noMatch;
    } else {
      return null;
    }
  }

//valid Phone data============================================================
  static String? validatorPhone(phone) {
    final phoneRegExp = RegExp(r"^\s*[0-9]{10}$");
    if (phone.trim().isEmpty) {
      return AppMessage.mandatoryTx;
    }
    // if (phoneRegExp.hasMatch(phone) == false) {
    //   return AppMessage.invalidPhone;
    // }
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





}
