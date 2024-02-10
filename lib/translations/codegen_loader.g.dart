// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> ar = {
  "selectLocation": "اختر الموقع",
  "appName": "خرائط الحرم",
  "distancenation": "وجهتك",
  "saveFirest": "عليك حفظ معلومات خيمتك اولا",
  "messageSend": "ان مرسل الرسالة مصاب بوعكة صحية الرجاء تتبع الموقع لاسعافه في اسرع وقت",
  "campInfo": "معلومات المخيم",
  "youWont": "المراد الوصول اليه",
  "totalDistance": "المسافة الكلية",
  "time": "الزمن",
  "enableLocation": "للحصول على تجربة مستخدم افضل الرجاء تفعيل اذن الوصول الى الموقع الجغرافي",
  "active": "تفعيل",
  "clickSaveLocation": "اضغط على الرابط لحفظ الموقع",
  "canSaveLocation": "يمكنك حقظ موقع المخيم الخاص بك",
  "done": "تم حفظ الموقع بنجاح",
  "me": "انا",
  "selectLang": "اختر اللغة",
  "setting": "اعدادات الموقع الجغرافي"
};
static const Map<String,dynamic> en = {
  "selectLocation": "Choose location",
  "appName": "Haram maps",
  "distancenation": "Your destination",
  "saveFirest": "You must save your tent information first",
  "messageSend": "The sender of the message is ill. Please follow the website to treat him as soon as possible",
  "campInfo": "Camp information",
  "youWont": "to be reached",
  "totalDistance": "Total distance",
  "time": "Time",
  "enableLocation": "For a better user experience, please activate permission to access location",
  "active": "activation",
  "clickSaveLocation": "Click on the link to save the site",
  "canSaveLocation": "You can save your campsite",
  "done": "The location has been saved successfully",
  "me": "me",
  "selectLang": "choose the language",
  "setting": "Location settings"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ar": ar, "en": en};
}
