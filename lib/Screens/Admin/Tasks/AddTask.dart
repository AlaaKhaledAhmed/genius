import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius/Widget/AppBar.dart';
import 'package:genius/Widget/AppMessage.dart';
import 'package:genius/Widget/GeneralWidget.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  @override
  Widget build(BuildContext context) {
    TextEditingController userNameController = TextEditingController();
    final key1 = GlobalKey<State<StatefulWidget>>();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBarWidget(
        text: AppMessage.addTask,
        isBasics: true,
      ),
      body: GeneralWidget.body(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Column(
          children: [
            
          ],
        ),
      )),
    );
  }
}
