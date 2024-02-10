class AppMessage {
  static String successfulRequest = 'successful';
  static String unAuthorized = 'unAuthorized';
  static String serverExceptions = 'serverExceptions';
  static String socketException = 'socketException';
  static String timeoutException = 'timeoutException';
  static String formatException = 'formatException';
  static String unAuthorizedText =
      'انتهت صلاحية الجلسة'; //"نحن آسفون ولكننا غير قادرين على التحقق من هويتك. يجب عليك تسجيل الدخول";
  static String tryAgain = 'إعادة المحاولة';
  static String serverText = "حدث خطأ ما اثناء معالجة طلبك";
  static String socketText = 'لايوجد اتصال بالانترنت';
  static String timeoutText =
      'يبدو أن الخادم يستغرق وقتًا طويلاً للاستجابة، حاول مجدداً بعد فترة';
  static String formatText = 'حدث خطا ما';
  static String noData = 'لاتوجد بيانات لعرضها';

  static String mandatoryTx = 'حقل اجباري';
  static String yes = 'نعم';
  static String no = 'لا';
  static String englishOnlyValidation =
      'يجب ان يكون اسم المستخدم باللغة الانجليزية';
  static String noLessThan4 = "الحد الادنى 4 خانات";
  static String noMoreThan14 = "يجب ان  لا يكون الاسم اكثر من  14 خانات";
  static String arabicOnlyValidation = 'يجب ان يكون الاسم حروف باللغة العربية ';
  static String pleaseEnterFullName = 'الرجاء كتابة الاسم الثلاثي الكامل';
  static String invalidEmail = 'البريد الالكتروني غير صالح';
  static String invalidPassword =
      'يجب أن يكون طول نص كلمة المرور على الأقل 8 حروفٍ/حرفًا'; //'كلمة المرور يجب ان لا تقل عن 8 خانات';
  static String noMatch = 'كلمة المرور و تأكيد كلمة المرور لا تتطابق';
  static String startWithZero = 'يجب ان لا يبدأ رقم الجوال بالرقم 0';
  static String startWith5 = 'يجب ان يبدأ رقم الجوال بالرقم 5';
  static String noLessThan9 = "يجب ان يكون رقم الجوال 9 خانات";
  static String invalidPhone = 'رقم الجوال غير صالح';
  static String location = 'الموقع الجغرافي';
  static String email = 'البريد الالكتروني';
  static String passwordTx = 'كلمة المرور';
  static String loginTx = "تسجيل الدخول";
}
