import 'package:flutter/material.dart';

import '../../Widget/AppBar.dart';
import '../../Widget/AppMessage.dart';

class EndOfServiceCalculator extends StatefulWidget {
  const EndOfServiceCalculator({super.key});

  @override
  State<EndOfServiceCalculator> createState() => _EndOfServiceCalculatorState();
}

class _EndOfServiceCalculatorState extends State<EndOfServiceCalculator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        text: AppMessage.endOfServiceCalculator,
      ),
    );
  }
}
