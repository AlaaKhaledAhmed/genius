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
                        .map((item) => item.containSubCategory == true
                            ? StatefulBuilder(builder: (context, se2) {
                                return ExpansionTile(
                                  onExpansionChanged: (bool expanded) {
                                    se2(() {
                                      isExpanded = expanded;
                                    });
                                  },

                                  shape: Border(
                                    top: BorderSide(color: AppColor.white),
                                    bottom: BorderSide(color: AppColor.white),
                                  ),
                                  tilePadding: EdgeInsets.symmetric(horizontal: 5.w),

                                  ///title=======
                                  title: AppText(
                                    text: item.title,
                                    fontSize: AppSize.subTextSize,
                                    color: AppColor.white,
                                  ),

                                  ///trailing=======
                                  trailing: Icon(
                                    Icons.arrow_drop_down_circle_outlined,
                                    color: AppColor.white,
                                    size: AppSize.iconsSize,
                                  ),

                                  ///leading=======
                                  leading: Icon(
                                    item.icon,
                                    color: AppColor.white,
                                    size: AppSize.iconsSize,
                                  ),

                                  ///sum item=======
                                  children: (DrawerItems.contractsSubItem)
                                      .map(
                                        (subItem) => ListTile(
                                           contentPadding:EdgeInsets.symmetric(horizontal: 5.w),
                                            horizontalTitleGap: 0.spMin,
                                            title: AppText(
                                              text: subItem.title,
                                              fontSize: AppSize.subTextSize,
                                              color: AppColor.white,
                                            ),
                                            leading: Icon(
                                              subItem.icon,
                                              color: AppColor.white,
                                              size: AppSize.iconsSize,
                                            ),
                                            onTap: () {
                                              ///close drawer
                                              Navigator.pop(context);
                                              print(
                                                  'subItem: ${subItem.title}');
                                              // AppConstants.drawerController.toggle!();
                                              context
                                                  .read<ProviderClass>()
                                                  .onTapDrawerItem(
                                                      subItem.itemIndex!);
                                            }),
                                      )
                                      .toList(),
                                );
                              })
                            : ListTile(
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
                                          .onTapDrawerItem(item.itemIndex!);
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
//task
  static DrawerItem manageUsers = DrawerItem(
    itemIndex: AppConstants.manageUsersId,
    title: AppMessage.manageUsers,
    icon: AppIcons.manageUsers,
  );
//profile
  static DrawerItem profile = DrawerItem(
    itemIndex: AppConstants.profileId,
    title: AppMessage.profile,
    icon: AppIcons.profile,
  ); //profile
  static DrawerItem sections = DrawerItem(
    itemIndex: AppConstants.sectionsId,
    title: AppMessage.sections,
    icon: AppIcons.sections,
  ); //profile
  static DrawerItem calender = DrawerItem(
    itemIndex: AppConstants.calenderId,
    title: AppMessage.calender,
    icon: AppIcons.calender,
  );
  static DrawerItem contract = DrawerItem(
    containSubCategory: true,
    itemIndex: AppConstants.contract,
    title: AppMessage.contract,
    icon: AppIcons.empContracts,
  ); //profile

  static final contractsSubItem = [
    DrawerItem(
      itemIndex: AppConstants.empContractsId,
      title: AppMessage.empContracts,
      icon: AppIcons.empContracts,
    ), //profile
    DrawerItem(
      itemIndex: AppConstants.projectsContractsId,
      title: AppMessage.projectsContracts,
      icon: AppIcons.projectsContracts,
    )
  ];
  //profile
  static DrawerItem endOfServiceCalculator = DrawerItem(
    itemIndex: AppConstants.endOfServiceCalculatorId,
    title: AppMessage.endOfServiceCalculator,
    icon: AppIcons.endOfServiceCalculator,
  ); //profile

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
    profile,
    manageUsers,
    sections,
    task,
    audience,
    elevateEmploy,
    administrativeCircular,
    administrativeRequests,
    calender,
    contract,
    endOfServiceCalculator,
    complaints,
    logOut,
  ];
}
