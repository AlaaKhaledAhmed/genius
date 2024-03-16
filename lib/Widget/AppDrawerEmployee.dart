import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../BackEnd/provider_class.dart';
import '../Screens/Authentication/LogIn.dart';
import '../generated/assets.dart';
import 'AppColor.dart';
import 'AppConstants.dart';
import 'AppIcons.dart';
import 'AppMessage.dart';
import 'AppRoutes.dart';
import 'AppSize.dart';
import 'AppText.dart';
import 'GeneralWidget.dart';

class AppDrawerEmployee extends StatefulWidget {
  const AppDrawerEmployee({
    Key? key,
  }) : super(key: key);

  @override
  State<AppDrawerEmployee> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawerEmployee> {
  ScrollController controller = ScrollController();
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
//text===================================================================================
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.spMin),
            alignment: AlignmentDirectional.center,
            height: 120.w,
            decoration: GeneralWidget.decoration(
                shadow: false,
                color: AppColor.white,
                radius: 0,
                image: const AssetImage(Assets.imageLogoRemoveBg)),
          ),
//items===================================================================================
          Flexible(
            child: Scrollbar(
              thickness: 4,
              scrollbarOrientation: ScrollbarOrientation.right,
              controller: controller,
              radius: Radius.circular(20.r),
              child: Container(
                color: AppColor.mainColor,
                child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    controller: controller,
                    children: DrawerItems.allListItem
                        .map((item) => ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 5.w, vertical: 5.h),
                              horizontalTitleGap: 20.spMin,
                              title: AppText(
                                text: item.title,
                                fontSize: AppSize.subTextSize,
                                color: AppColor.white,
                              ),
                              leading: Icon(
                                item.icon,
                                color: AppColor.white,
                                size: AppSize.iconsSize,
                              ),
                              onTap: () async {
                                ///close drawer
                                Navigator.pop(context);
                                item.itemIndex == AppConstants.logOutId
                                    ? {

                                        await FirebaseAuth.instance.signOut(),
                                        AppRoutes.pushAndRemoveAllPageTo(
                                            context, const Login(),
                                            removeProviderData: true)
                                      }
                                    : context
                                        .read<ProviderClass>()
                                        .onTapDrawerItemEmp(item.itemIndex!);
                                print('subItem: ${item.title}');
                              },
                              // onTap: () => widget.onSelect(item),
                            ))
                        .toList()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

///=================================================================================
class DrawerItem {
  final int? itemIndex;
  final String title;
  final IconData icon;
  final bool? containSubCategory;
  DrawerItem({
    this.itemIndex,
    required this.title,
    required this.icon,
    this.containSubCategory,
  });
}

///=====================================================================================
class DrawerItems {
//profile
  static DrawerItem profile = DrawerItem(
    itemIndex: AppConstants.profileIdEm,
    title: AppMessage.profile,
    icon: AppIcons.profile,
  ); //profile
  //profile

  static DrawerItem endOfServiceCalculator = DrawerItem(
    itemIndex: AppConstants.endOfServiceCalculatorIdEm,
    title: AppMessage.endOfServiceCalculator,
    icon: AppIcons.endOfServiceCalculator,
  ); //profile

  //task
  static DrawerItem task = DrawerItem(
    itemIndex: AppConstants.taskIdEm,
    title: AppMessage.task,
    icon: AppIcons.task,
  );

//audience
  static DrawerItem audience = DrawerItem(
    title: AppMessage.audience,
    icon: AppIcons.audience,
    itemIndex: AppConstants.audienceIdEm,
  );

//administrativeCircular
  static DrawerItem administrativeCircular = DrawerItem(
      title: AppMessage.administrativeCircular,
      icon: AppIcons.administrativeCircular,
      itemIndex: AppConstants.administrativeCircularIdEm);

//administrativeRequests
  static DrawerItem administrativeRequests = DrawerItem(
      title: AppMessage.administrativeRequests,
      icon: AppIcons.administrativeRequests,
      itemIndex: AppConstants.administrativeRequestsIdEm);

// complaints
  static DrawerItem complaints = DrawerItem(
      title: AppMessage.complaints,
      icon: AppIcons.complaints,
      itemIndex: AppConstants.complaintsIdEm);

// logout
  static DrawerItem logOut = DrawerItem(
      title: AppMessage.logOut,
      icon: AppIcons.logOut,
      itemIndex: AppConstants.logOutId);

  ///=====================================================================================
  static final List<DrawerItem> allListItem = [
    profile,
    task,
    audience,
    administrativeCircular,
    administrativeRequests,
    endOfServiceCalculator,
    complaints,
    logOut,
  ];
}
