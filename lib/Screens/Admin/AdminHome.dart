import 'package:flutter/material.dart';
import 'package:genius/Widget/AppBar.dart';
import 'package:genius/Widget/AppMessage.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(text: AppMessage.home,),
      body: Column(),
    );
  }
}
