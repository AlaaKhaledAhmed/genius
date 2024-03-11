import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Widget/AppBar.dart';
import '../../../Widget/AppButtons.dart';
import '../../../Widget/AppIcons.dart';
import '../../../Widget/AppMessage.dart';
import '../../../Widget/AppRoutes.dart';
import 'AddProject.dart';

class ProjectsMain extends StatefulWidget {
  const ProjectsMain({Key? key}) : super(key: key);

  @override
  State<ProjectsMain> createState() => _ProjectsMainState();
}

class _ProjectsMainState extends State<ProjectsMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        text: AppMessage.projectManagement,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            child: AppButtons(
              onPressed: () {
                AppRoutes.pushTo(context, const AddProject());
              },
              text: AppMessage.addProject,
              icon: AppIcons.add,
            ),
          ),
          Expanded(flex: 5, child: Container())
        ],
      ),
    );
  }
}
