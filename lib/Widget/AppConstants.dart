import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class AppConstants {
  static String employ='employ';
  static String admin='admin';
  static String spurt='spurt';
  static const Duration timeOut = Duration(seconds: 15);

  static CollectionReference userCollection =
  FirebaseFirestore.instance.collection('users');



}
