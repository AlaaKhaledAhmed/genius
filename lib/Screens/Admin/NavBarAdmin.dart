import 'package:flutter/material.dart';
import 'package:genius/Screens/Admin/AdminHome.dart';
import 'package:provider/provider.dart';

import '../../BackEnd/provider_class.dart';
import '../../Widget/AppDrawer.dart';

class NavBarAdmin extends StatefulWidget {
  const NavBarAdmin({Key? key}) : super(key: key);

  @override
  State<NavBarAdmin> createState() => _NavBarAdminState();
}

class _NavBarAdminState extends State<NavBarAdmin> {
  List<Widget> pages = [AdminHome()];

  @override
  void initState() {
    super.initState();
    context.read<ProviderClass>().pageController = PageController(
        initialPage: context.read<ProviderClass>().currentPageIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<ProviderClass>().scaffoldKey,
      drawer: const AppDrawer(),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: context.read<ProviderClass>().pageController,
        children: pages,
      ),
    );
  }
}
