import 'package:flutter/material.dart';
import 'package:genius/Screens/Admin/AdministrativeCircular/AdministrativeCircular.dart';
import 'package:genius/Screens/Admin/AdministrativeRequests/AdministrativeRequests.dart';
import 'package:genius/Screens/Admin/Audience/AdminAudience.dart';
import 'package:genius/Screens/Admin/Complaints/Complaints.dart';
import 'package:genius/Screens/Admin/ElevateEmploy/ElevateEmploy.dart';
 import 'package:genius/Screens/Admin/Tasks/AdminTask.dart';
import 'package:provider/provider.dart';

import '../../BackEnd/provider_class.dart';
import '../../Widget/AppDrawer.dart';
import 'ManageEmploy/ManageEmploy.dart';

class NavBarAdmin extends StatefulWidget {
  const NavBarAdmin({Key? key}) : super(key: key);

  @override
  State<NavBarAdmin> createState() => _NavBarAdminState();
}

class _NavBarAdminState extends State<NavBarAdmin> {
  List<Widget> pages = [
    const ManageEmploy(),
    const AdminTask(),
    const AdminAudience(),
    const ElevateEmploy(),
    const AdministrativeCircular(),
    const AdministrativeRequests(),
    const Complaints(),
  ];

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
