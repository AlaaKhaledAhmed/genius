import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../BackEnd/provider_class.dart';
import '../Screens/Authentication/LogIn.dart';
import 'AppColor.dart';
import 'AppConstants.dart';
import 'AppIcons.dart';
import 'AppMessage.dart';
import 'AppRoutes.dart';
import 'AppSize.dart';
import 'AppText.dart';
import 'GeneralWidget.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  ScrollController controller = ScrollController();
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: false,
      child: Drawer(
        child: Column(
          children: [
//text===================================================================================
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.spMin),
              alignment: AlignmentDirectional.center,
              decoration: GeneralWidget.decoration(
                  shadow: false, color: AppColor.mainColor, radius: 0),
            ),
//items===================================================================================
            Flexible(
              child: Scrollbar(
                thickness: 4,
                scrollbarOrientation: ScrollbarOrientation.right,
                controller: controller,
                radius: Radius.circular(20.r),
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
                                color: AppColor.textColor,
                              ),
                              leading: Icon(
                                item.icon,
                                color: AppColor.textColor,
                                size: AppSize.iconsSize,
                              ),
                              onTap: () {
                                ///close drawer
                                Navigator.pop(context);
                                item.itemIndex == AppConstants.logOutId
                                    ? {
                                        context
                                            .read<ProviderClass>()
                                            .emptyProviderData(),
                                        AppRoutes.pushAndRemoveAllPageTo(
                                            context, const Login(),
                                            removeProviderData: true)
                                      }
                                    : context
                                        .read<ProviderClass>()
                                        .onTapDrawerItem(item.itemIndex!);
                                print('subItem: ${item.title}');
                              },
                              // onTap: () => widget.onSelect(item),
                            ))
                        .toList()),
              ),
            ),
          ],
        ),
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
//task
  static DrawerItem task = DrawerItem(
    itemIndex: AppConstants.taskId,
    title: AppMessage.task,
    icon: AppIcons.task,
  );

//audience
  static DrawerItem audience = DrawerItem(
    title: AppMessage.audience,
    icon: AppIcons.audience,
    itemIndex: AppConstants.audienceId,
  );

//elevateEmploy
  static DrawerItem elevateEmploy = DrawerItem(
    title: AppMessage.elevateEmploy,
    icon: AppIcons.elevateEmploy,
    itemIndex: AppConstants.elevateEmployId,
  );

//administrativeCircular
  static DrawerItem administrativeCircular = DrawerItem(
      title: AppMessage.administrativeCircular,
      icon: AppIcons.administrativeCircular,
      itemIndex: AppConstants.administrativeCircularId);

//administrativeRequests
  static DrawerItem administrativeRequests = DrawerItem(
      title: AppMessage.administrativeRequests,
      icon: AppIcons.administrativeRequests,
      itemIndex: AppConstants.administrativeRequestsId);

// complaints
  static DrawerItem complaints = DrawerItem(
      title: AppMessage.complaints,
      icon: AppIcons.complaints,
      itemIndex: AppConstants.complaintsId);

// logout
  static DrawerItem logOut = DrawerItem(
      title: AppMessage.logOut,
      icon: AppIcons.logOut,
      itemIndex: AppConstants.logOutId);



  ///=====================================================================================
  static final List<DrawerItem> allListItem = [
    task,
    audience,
    elevateEmploy,
    administrativeCircular,
    administrativeRequests,
    complaints,
    logOut,
  ];
}
