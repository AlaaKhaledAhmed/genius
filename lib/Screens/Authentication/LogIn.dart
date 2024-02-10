import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius/Widget/AppDialog.dart';
import 'package:genius/Widget/AppSize.dart';
import 'package:genius/Widget/AppText.dart';
import 'package:genius/Widget/ImagePath.dart';
import '../../BackEnd/Database/DatabaseMethods..dart';
import '../../Widget/AppButtons.dart';
import '../../Widget/AppColor.dart';
import '../../Widget/AppConstants.dart';
import '../../Widget/AppDropList.dart';
import '../../Widget/AppImage.dart';
import '../../Widget/AppMessage.dart';
import '../../Widget/AppRoutes.dart';
import '../../Widget/AppTextFields.dart';
import '../../Widget/AppValidator.dart';
import '../Admin/AdminHome.dart';
import '../Employ/EmployHome.dart';
import '../Sppurt.dart';

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
        decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: bcImage.image,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.6), BlendMode.darken),
                fit: BoxFit.cover)),
        child: Form(
          key: logKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                  text: AppMessage.loginTx,
                  fontSize: AppSize.textSize,
                  fontWeight: FontWeight.bold,
                  color: AppColor.white,
                ),
                SizedBox(
                  height: 15.h,
                ),
//==============================Email===============================================================
                AppTextFields(
                  controller: emailController,
                  labelText: AppMessage.email,
                  validator: (v) => AppValidator.validatorEmail(v),
                  obscureText: false,
                ),
                SizedBox(
                  height: 10.h,
                ),
//==============================Password===============================================================
                AppTextFields(
                  controller: passwordController,
                  labelText: AppMessage.passwordTx,
                  validator: (v) => AppValidator.validatorPassword(v),
                  obscureText: true,
                ),
                SizedBox(
                  height: 10.h,
                ),
//===============================Add Button===============================================================
                AppButtons(
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
                          AppLoading.show(context, AppMessage.loginTx,
                              AppMessage.serverText);
                        } else if (v == 'user-not-found') {
                          AppLoading.show(context, AppMessage.loginTx,
                              AppMessage.invalidEmail);
                        } else {
                          FirebaseFirestore.instance
                              .collection('users')
                              .where('userId', isEqualTo: v)
                              .get()
                              .then((value) {
                            Navigator.pop(context);
                            value.docs.forEach((element) {
                              print('respoms is: $v');
                              print('name is: ${element.data()['name']}');
                              print('type is: ${element.data()['type']}');
                              if (element.data()['type'] ==
                                  AppConstants.employ) {
                                AppRoutes.pushReplacementTo(
                                    context, const EmployHome());
                              } else if (element.data()['type'] ==
                                  AppConstants.spurt) {
                                AppRoutes.pushReplacementTo(
                                    context, const SpurtHome());
                              } else if (element.data()['type'] ==
                                  AppConstants.admin) {
                                AppRoutes.pushReplacementTo(
                                    context, const AdminHome());
                              } else {
                                AppLoading.show(context, AppMessage.loginTx,
                                    AppMessage.serverText);
                              }
                            });
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
      ),
    );
  }
}
