import 'package:flutter/material.dart';
import 'package:genius/Screens/Employ/AdministrativeCircularEmp.dart';
 import 'package:genius/Widget/AppDrawerEmployee.dart';
import 'package:provider/provider.dart';
import '../../BackEnd/provider_class.dart';
import 'AdministrativeRequestsEmp/AdministrativeRequestsEmp.dart';
import 'EmployeeTasks/EmployeeTasks.dart';
import 'ProfileEmp.dart';

class EmployeeNavBar extends StatefulWidget {
  static String route = '/NavBarEmp';

  const EmployeeNavBar({super.key});

  @override
  State<EmployeeNavBar> createState() => _EmployeeNavBarState();
}

class _EmployeeNavBarState extends State<EmployeeNavBar> {
  List<Widget> pages = [
    const ProfileEmp(),
    const EmployeeTask(),
    const EmployeeTask(),
    const AdministrativeCircularEmp(),
    const AdministrativeRequestsEmp()
  ];

  @override
  void initState() {
    super.initState();
    context.read<ProviderClass>().pageController = PageController(
        initialPage: context.read<ProviderClass>().currentPageIndexEmp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<ProviderClass>().scaffoldKeyEmp,
      drawer: const AppDrawerEmployee(),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: context.read<ProviderClass>().pageController,
        children: pages,
      ),
    );
  }
}
