import 'package:flutter/material.dart';
import 'package:genius/Screens/Employ/AdministrativeCircularEmp.dart';
import 'package:genius/Widget/AppDrawerEmployee.dart';
import 'package:provider/provider.dart';

import '../../BackEnd/provider_class.dart';
import 'EmployeeTasks/EmployeeTasks.dart';

class EmployeeNavBar extends StatefulWidget {
  static String route = '/employeeNavBar';
  const EmployeeNavBar({super.key});

  @override
  State<EmployeeNavBar> createState() => _EmployeeNavBarState();
}

class _EmployeeNavBarState extends State<EmployeeNavBar> {
  List<Widget> pages = [
    const EmployeeTask(), const EmployeeTask(), const EmployeeTask(),
    const AdministrativeCircularEmp(),
    // const ManageEmploy(),
    // const Sections(),
    // const AdminIndividualTasks(),
    // const AdminAudience(),
    // const ElevateEmploy(),
    // const AdministrativeCircular(),
    // const AdministrativeRequests(),
    // const Calender(),
    // const EmpContracts(),
    // const EmpContracts(),
    // const ProjectsContracts(),
    // const EndOfServiceCalculator(),
    // const Complaints(),
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
