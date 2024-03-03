import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:genius/Widget/AppMessage.dart';

class AppConstants {
  static String employ = 'employ';
  static String admin = 'admin';
  static String spurt = 'spurt';
  static int newStatus = 0;

  static const Duration timeOut = Duration(seconds: 15);

  ///not chang id or resort item=>using in page-view
  static const int profileId = 0;
  static const int manageUsersId = 1;
  static const int sectionsId =2;

  static const int taskId = 3;
  static const int audienceId = 4;
  static const int elevateEmployId = 5;
  static const int administrativeCircularId = 6;
  static const int administrativeRequestsId = 7;
  static const int calenderId = 8;
  static const int contract=9;
  static const int empContractsId = 10;
  static const int projectsContractsId = 11;
  static const int endOfServiceCalculatorId = 12;
  static const int complaintsId = 13;
  static const int logOutId = 14;
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
