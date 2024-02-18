import 'package:flutter/material.dart';
import 'package:genius/Widget/AppBar.dart';
import 'package:genius/Widget/AppMessage.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(text: AppMessage.addTask,
      isBasics: true,
      ),
    );
  }
}
