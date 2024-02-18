import 'package:flutter/material.dart';

import '../../../Widget/AppBar.dart';
import '../../../Widget/AppMessage.dart';

class AdministrativeCircular extends StatefulWidget {
  const AdministrativeCircular({Key? key}) : super(key: key);

  @override
  State<AdministrativeCircular> createState() => _AdministrativeCircularState();
}

class _AdministrativeCircularState extends State<AdministrativeCircular> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        text: AppMessage.administrativeCircular,
      ),
    );
  }
}
