import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius/Screens/Employ/EmployeeNavBar.dart';
import 'package:genius/Widget/AppDialog.dart';
import 'package:genius/Widget/AppSize.dart';
import 'package:genius/Widget/AppText.dart';
import 'package:genius/Widget/GeneralWidget.dart';
import 'package:genius/Widget/ImagePath.dart';
import 'package:genius/generated/assets.dart';
import '../../BackEnd/Database/DatabaseMethods..dart';
import '../../Widget/AppButtons.dart';
import '../../Widget/AppColor.dart';
import '../../Widget/AppConstants.dart';
import '../../Widget/AppMessage.dart';
import '../../Widget/AppRoutes.dart';
import '../../Widget/AppTextFields.dart';
import '../../Widget/AppValidator.dart';
import '../Admin/NavBarAdmin.dart';
import '../Sppurt/Sppurt.dart';

class Login extends StatefulWidget {
  static String route = '/login';
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late Image bcImage;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> logKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    bcImage = Image.asset(ImagePath.back);
  }

  @override
  void didChangeDependencies() {
    precacheImage(bcImage.image, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
      decoration: GeneralWidget.decoration(isGradient: true),
      child: Form(
        key: logKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 120.spMin,
                width: 120.spMin,
                decoration: GeneralWidget.decoration(
                    image: const AssetImage(Assets.imageLogo)),
              ),
              SizedBox(
                height: 20.h,
              ),
              AppText(
                text: AppMessage.welcome,
                fontSize: AppSize.subTextSize,
                fontWeight: FontWeight.bold,
                color: AppColor.white,
                align: TextAlign.center,
              ),
              SizedBox(
                height: 15.h,
              ),
//==============================Email===============================================================
              AppTextFields(
                controller: emailController,
                labelText: AppMessage.email,
                validator: (v) => AppValidator.validatorEmpty(v),
                obscureText: false,
              ),
              SizedBox(
                height: 10.h,
              ),
//==============================Password===============================================================
              AppTextFields(
                controller: passwordController,
                labelText: AppMessage.passwordTx,
                validator: (v) => AppValidator.validatorEmpty(v),
                obscureText: true,
              ),
              SizedBox(
                height: 10.h,
              ),
//===============================Add Button===============================================================
              AppButtons(
                width: double.maxFinite,
                text: AppMessage.loginTx,
                backgroundColor: AppColor.mainColor,
                onPressed: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  if (logKey.currentState?.validate() == true) {
                    AppLoading.show(context, 'lode', 'lode');

                    Database.loggingToApp(
                            email: emailController.text.trim(),
                            password: passwordController.text)
                        .then((String v) {
                      Navigator.pop(context);
                      if (v == 'error') {
                        AppLoading.show(
                            context, AppMessage.loginTx, AppMessage.serverText);
                      } else if (v == 'user-not-found') {
                        AppLoading.show(context, AppMessage.loginTx,
                            AppMessage.userNotFound);
                      } else {
                        FirebaseFirestore.instance
                            .collection('users')
                            .where('userId', isEqualTo: v)
                            .get()
                            .then((value) {
                          Navigator.pop(context);
                          for (var element in value.docs) {
                            print('responses is: $v');
                            color_print('typpe is: ${element.data()['type']}');
                            if (element.data()['type'] == AppConstants.employ) {
                              AppRoutes.pushReplacementTo(
                                  context, const EmployeeNavBar());
                            } else if (element.data()['type'] ==
                                AppConstants.spurt) {
                              AppRoutes.pushReplacementTo(
                                  context, const SpurtHome());
                            } else if (element.data()['type'] ==
                                AppConstants.admin) {
                              AppRoutes.pushReplacementTo(
                                  context, const NavBarAdmin());
                            } else {
                              AppLoading.show(context, AppMessage.loginTx,
                                  AppMessage.userNotFound);
                            }
                          }
                        });
                      }
                    });
                  }
                },
              )
            ],
          ),
        ),
      ),
    ));
  }
}
