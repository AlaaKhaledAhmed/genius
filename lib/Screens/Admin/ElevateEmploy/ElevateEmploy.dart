import 'package:flutter/material.dart';

import '../../../Widget/AppBar.dart';
import '../../../Widget/AppMessage.dart';

class ElevateEmploy extends StatefulWidget {
  const ElevateEmploy({Key? key}) : super(key: key);

  @override
  State<ElevateEmploy> createState() => _ElevateEmployState();
}

class _ElevateEmployState extends State<ElevateEmploy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        text: AppMessage.elevateEmploy,
      ),
    );
  }
}
