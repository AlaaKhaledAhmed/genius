

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

typedef OnUploadProgressCallbackAdv = void Function(double progress);

class ProviderClass extends ChangeNotifier {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int currentPageIndex = 2;
  PageController? pageController;

  ///update page index==========================================================================
  void onTapDrawerItem(int index) async {
    currentPageIndex = index;
    notifyListeners();
    pageController?.animateToPage(currentPageIndex,
        duration: const Duration(milliseconds: 100), curve: Curves.ease);
    print('index is: $currentPageIndex');
  }

  ///open-close drawer ==========================================================================
  void controlMenu() {
    if (!scaffoldKey.currentState!.isDrawerOpen) {
      scaffoldKey.currentState!.openDrawer();
    }
  }
  emptyProviderData() {

  }
}
