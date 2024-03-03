import 'package:flutter/material.dart';

import '../../../Widget/AppBar.dart';
import '../../../Widget/AppMessage.dart';

class EmpContracts extends StatefulWidget {
  const EmpContracts({super.key});

  @override
  State<EmpContracts> createState() => _EmpContractsState();
}

class _EmpContractsState extends State<EmpContracts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        text: AppMessage.empContracts,
      ),
    );
  }
}
