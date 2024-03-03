import 'package:flutter/material.dart';
import 'package:genius/Screens/Admin/AdministrativeCircular/AdministrativeCircular.dart';
import 'package:genius/Screens/Admin/AdministrativeRequests/AdministrativeRequests.dart';
import 'package:genius/Screens/Admin/Audience/AdminAudience.dart';
import 'package:genius/Screens/Admin/Complaints/Complaints.dart';
import 'package:genius/Screens/Admin/Contracts/EmpContracts.dart';
import 'package:genius/Screens/Admin/Contracts/ProjectsContracts.dart';
import 'package:genius/Screens/Admin/ElevateEmploy/ElevateEmploy.dart';
import 'package:genius/Screens/Admin/Tasks/AdminTask.dart';
import 'package:provider/provider.dart';
import '../../BackEnd/provider_class.dart';
import '../../Widget/AppDrawer.dart';
import 'Calender/Calender.dart';
import 'EndOfServiceCalculator.dart';
import 'ManageEmploy/ManageEmploy.dart';
import 'Profile/Profile.dart';
import 'Sections/ProjectsHome.dart';

class NavBarAdmin extends StatefulWidget {
  const NavBarAdmin({Key? key}) : super(key: key);

  @override
  State<NavBarAdmin> createState() => _NavBarAdminState();
}

class _NavBarAdminState extends State<NavBarAdmin> {
  List<Widget> pages = [
    const Profile(),
    const ManageEmploy(),
    const Sections(),
    const AdminTask(),
    const AdminAudience(),
    const ElevateEmploy(),
    const AdministrativeCircular(),
    const AdministrativeRequests(),
    const Calender(),
    const EmpContracts(),
    const EmpContracts(),
    const ProjectsContracts(),
    const EndOfServiceCalculator(),
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
