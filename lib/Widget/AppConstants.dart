import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:genius/Widget/AppMessage.dart';

class AppConstants {
  static String employ = 'employ';
  static String admin = 'admin';
  static String spurt = 'spurt';static int newStatus = 0;

  static const Duration timeOut = Duration(seconds: 15);

  ///not chang id or resort item=>using in page-view
  static const int manageUsersId = 0;
  static const int taskId = 1;
  static const int audienceId = 2;
  static const int elevateEmployId = 3;
  static const int administrativeCircularId = 4;
  static const int administrativeRequestsId = 5;
  static const int complaintsId = 6;
  static const int logOutId = 7;
  static CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  static CollectionReference taskCollection =
      FirebaseFirestore.instance.collection('task');
  static CollectionReference administrativeCircularCollection =
      FirebaseFirestore.instance.collection('administrativeCircular');
  static List<String> sectionListAr = [
    'Personnel Department',
    'Employee Relations',
    'Organizational Development',
    'Workforce Management',
    'Employee Services',
    'HR Administration',
  ];
  static List<String> sectionListEn = [
    'إدارة شؤون الموظفين',
    'علاقات الموظفين',
    'التطوير التنظيمي',
    'إدارة القوى العاملة',
    'خدمات الموظفين',
    'الموارد البشرية والإدارة',
  ];
}
