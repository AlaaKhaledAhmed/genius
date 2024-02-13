import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius/Screens/Authentication/LogIn.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Widget/AppColor.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  return runApp(EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('ar'),
      child: const MyApp()));
}

class MyApp extends StatefulWidget {
  ///using this key to navigate to screen when notifications comes
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String initialRoute = Login.route;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, __) => MaterialApp(
              initialRoute: initialRoute,
              routes: <String, WidgetBuilder>{
                Login.route: (_) => const Login(),
              },
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: const Locale('ar'),
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  scaffoldBackgroundColor: AppColor.inputBG,
                  // useMaterial3: true,
                  fontFamily: GoogleFonts.readexPro().fontFamily,
                  textSelectionTheme: TextSelectionThemeData(
                      cursorColor: AppColor.mainColor,
                      selectionHandleColor: AppColor.mainColor,
                      selectionColor: AppColor.darkGrey)),
            )

        //SplashScreen()

        );
  }

//====================================================================
}
