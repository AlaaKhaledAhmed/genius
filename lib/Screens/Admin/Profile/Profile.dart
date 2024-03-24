import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius/Widget/AppColor.dart';
import 'package:genius/Widget/AppSize.dart';
import 'package:genius/Widget/AppText.dart';
import 'package:genius/Widget/GeneralWidget.dart';

import '../../../BackEnd/Database/DatabaseMethods..dart';
import '../../../Widget/AppBar.dart';
import '../../../Widget/AppButtons.dart';
import '../../../Widget/AppDialog.dart';
import '../../../Widget/AppDrawerAdmin.dart';
import '../../../Widget/AppMessage.dart';
import '../../../Widget/AppTextFields.dart';
import '../../../Widget/AppValidator.dart';

class Profile extends StatefulWidget {
  static String route = '/profile';
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  var auth = FirebaseAuth.instance;
  var currentUser = FirebaseAuth.instance.currentUser;
  TextEditingController reenterPasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBarWidget(
        text: AppMessage.profile,
      ),
      body: GeneralWidget.body(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10.spMin),
                  decoration: GeneralWidget.decoration(),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 25.r,
                        backgroundColor: AppColor.lightGrey,
                        child: Icon(Icons.privacy_tip_outlined),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      AppText(
                          text: AppMessage.admin, fontSize: AppSize.subTextSize)
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
//===================================================================================
                AppTextFields(
                  controller: oldPasswordController,
                  labelText: AppMessage.oldPass,
                  validator: (v) => AppValidator.validatorEmpty(v),
                  obscureText: true,
                ),
                SizedBox(
                  height: 10.h,
                ),
//===================================================================================
                AppTextFields(
                  controller: newPasswordController,
                  labelText: AppMessage.newPass,
                  validator: (v) => AppValidator.validatorPassword(v),
                  obscureText: true,
                ),
                SizedBox(
                  height: 10.h,
                ),
//===================================================================================
                AppTextFields(
                  controller: reenterPasswordController,
                  labelText: AppMessage.confirmPass,
                  validator: (v) {
                    if (reenterPasswordController.text !=
                        newPasswordController.text) {
                      return 'كلمة لمرور غير متطابقة';
                    }
                    return null;
                  },
                  obscureText: true,
                ),
                SizedBox(
                  height: 10.h,
                ),
//===========================================================================================
                AppButtons(
                  width: double.infinity,
                  onPressed: () async {
                    if (formKey.currentState?.validate() == true) {
                      AppLoading.show(context, '', 'lode');
                      await Database.changePassword(
                        currentUser: currentUser,
                        email: currentUser!.email!,
                        oldPass: oldPasswordController.text,
                        newPassword: newPasswordController.text,
                      ).then((v) {
                        if (v == "done") {
                          Navigator.pop(context);
                          AppLoading.show(
                            context,
                            AppMessage.profile,
                            AppMessage.done,
                          );
                        } else if (v == 'wrong_password') {
                          Navigator.pop(context);
                          AppLoading.show(
                            context,
                            AppMessage.profile,
                            AppMessage.userNotFound,
                          );
                        } else {
                          Navigator.pop(context);
                          AppLoading.show(
                            context,
                            AppMessage.profile,
                            AppMessage.serverText,
                          );
                        }
                      });
                    }
                  },
                  text: 'تغيير كلمة المرور',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
