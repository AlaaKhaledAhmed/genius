import 'package:flutter/material.dart';

import '../../../Widget/AppBar.dart';
import '../../../Widget/AppMessage.dart';

class ProjectsContracts extends StatefulWidget {
  const ProjectsContracts({super.key});

  @override
  State<ProjectsContracts> createState() => _ProjectsContractsState();
}

class _ProjectsContractsState extends State<ProjectsContracts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        text: AppMessage.projectsContracts,
      ),
    );
  }
}
