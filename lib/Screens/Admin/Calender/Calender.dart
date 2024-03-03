import 'package:flutter/material.dart';

import '../../../Widget/AppBar.dart';
import '../../../Widget/AppMessage.dart';

class Calender extends StatefulWidget {
  const Calender({super.key});

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        text: AppMessage.calender,
      ),
    );
  }
}
