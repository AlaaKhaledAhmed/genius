import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class AppConstants {
  static String employ = 'employ';
  static String admin = 'admin';
  static String spurt = 'spurt';

  static const Duration timeOut = Duration(seconds: 15);

  ///not chang id or resort item=>using in page-view
  static const int taskId = 0;
  static const int audienceId = 1;
  static const int elevateEmployId = 2;
  static const int administrativeCircularId = 3;
  static const int administrativeRequestsId = 4;
  static const int complaintsId = 5;
  static const int logOutId = 6;
  static CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
}
