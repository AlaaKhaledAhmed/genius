import 'package:flutter/material.dart';

import '../../../Widget/AppBar.dart';
import '../../../Widget/AppMessage.dart';

class Sections extends StatefulWidget {
  const Sections({super.key});

  @override
  State<Sections> createState() => _SectionsState();
}

class _SectionsState extends State<Sections> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        text: AppMessage.sections,
      ),
    );
  }
}
