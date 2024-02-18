import 'package:flutter/material.dart';
import 'package:genius/Widget/AppBar.dart';
import 'package:genius/Widget/AppMessage.dart';

class AdminTask extends StatefulWidget {
  const AdminTask({super.key});

  @override
  State<AdminTask> createState() => _AdminTaskState();
}

class _AdminTaskState extends State<AdminTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(text: AppMessage.task,),
      body: Column(),
    );
  }
}
