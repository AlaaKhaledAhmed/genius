

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

typedef OnUploadProgressCallbackAdv = void Function(double progress);

class ProviderClass extends ChangeNotifier {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> scaffoldKeyEmp = GlobalKey<ScaffoldState>();
    int currentPageIndex = 2;
  int currentPageIndexEmp = 0;
  PageController? pageController;

  ///update page index==========================================================================
  void onTapDrawerItem(int index) async {
    currentPageIndex = index;
    notifyListeners();
    pageController?.animateToPage(currentPageIndex,
        duration: const Duration(milliseconds: 100), curve: Curves.ease);
    print('index is: $currentPageIndex');
  }
  void onTapDrawerItemEmp(int index) async {
    currentPageIndexEmp = index;
    notifyListeners();
    pageController?.animateToPage(currentPageIndexEmp,
        duration: const Duration(milliseconds: 100), curve: Curves.ease);
    print('index is: $currentPageIndexEmp');
  }

  ///open-close drawer ==========================================================================
  void controlMenu() {
    if (!scaffoldKey.currentState!.isDrawerOpen) {
      scaffoldKey.currentState!.openDrawer();
    }
  } void controlMenuEmp() {
    if (!scaffoldKeyEmp.currentState!.isDrawerOpen) {
      scaffoldKeyEmp.currentState!.openDrawer();
    }
  }
  emptyProviderData() {

  }
}
