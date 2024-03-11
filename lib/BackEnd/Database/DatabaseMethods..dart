import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../Widget/AppConstants.dart';

class Employee {
  final String name;
  final String id;
  Employee({required this.id, required this.name});
}

class Database {
  //=======================Student Sing up method======================================

  static Future<String> addEmploy({
    required String name,
    required String email,
    required String section,
    required String phone,
    required String salary,
    required String contract,
    required String employNaId,
    required String employNumber,
    required String nationalities,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.trim(), password: employNaId);
      if (userCredential.user != null) {
        await AppConstants.userCollection.add({
          'name': name,
          'userId': userCredential.user?.uid,
          'email': email,
          'section': section,
          'phone': phone,
          'salary': salary,
          'contract': contract,
          'employNaId': employNaId,
          'type': 'employ',
          'nationalities': nationalities,
          'employNumber': employNumber,
          'createdOn': FieldValue.serverTimestamp(),
        });
        return 'done';
      }
    } on FirebaseException catch (e) {
      if (e.code == 'weak-password') {
        return 'weak-password';
      }
      if (e.code == 'email-already-in-use') {
        return 'email-already-in-use';
      }
    } catch (e) {
      return e.toString();
    }
    return 'error';
  }

//employ Update Profile============================================================================================
  static Future<String> updateEmploy({
    required String name,
    required String section,
    required String phone,
    required String salary,
    required String contract,
    required String employNaId,
    required String docId,
    required String employNumber,
    required String nationalities,
  }) async {
    try {
      await AppConstants.userCollection.doc(docId).update({
        'name': name,
        'section': section,
        'phone': phone,
        'salary': salary,
        'contract': contract,
        'employNaId': employNaId,
        'nationalities': nationalities,
        'employNumber': employNumber,
      });
      return 'done';
    } catch (e) {
      return 'error';
    }
  }

//=======================Log in method======================================

  static Future<String> loggingToApp(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email.trim(), password: password);
      if (userCredential.user != null) {
        return '${userCredential.user?.uid}';
        //
      }
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        return 'user-not-found';
      }
      if (e.code == 'wrong-password') {
        return 'user-not-found';
      }
    } catch (e) {
      return 'error';
    }
    return 'error';
  }

  //changPassword===================================================================================
  static Future<String> changPassword(
      {currentUser,
      required String email,
      required String oldPass,
      required String newPassword}) async {
    try {
      var cred = EmailAuthProvider.credential(email: email, password: oldPass);
      await currentUser!.reauthenticateWithCredential(cred).then((value) {
        currentUser!.updatePassword(newPassword);
      });
      return 'done';
    } catch (e) {
      return 'error';
    }
  }

  //=======================Delete  method======================================
  static Future<String> delete({
    required String docId,
    required String collection,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection(collection)
          .doc(docId)
          .delete();
      return 'done';
    } catch (e) {
      return 'error';
    }
  }

  static Future<String> addTask({
    required String name,
    required String startDateStringFormat,
    required String endDateStringFormat,
    required DateTime startDate,
    required DateTime endDate,
    required String taskName,
    required String employNaId,
    required String userId,
  }) async {
    try {
      await AppConstants.taskCollection.add({
        'name': name,
        'userId': userId,
        'employNaId': employNaId,
        'startDateStringFormat': startDateStringFormat,
        'endDateStringFormat': endDateStringFormat,
        'startDate': startDate,
        'endDate': endDate,
        'taskName': taskName,
        'status': AppConstants.newStatus,
        'createdOn': FieldValue.serverTimestamp(),
      });
      return 'done';
    } catch (e) {
      return 'error';
    }
  }

  static Future<String> updateTask({
    required String name,
    required String startDateStringFormat,
    required String endDateStringFormat,
    required DateTime startDate,
    required DateTime endDate,
    required String taskName,
    required String employNaId,
    required String userId,
    required String docId,
  }) async {
    try {
      await AppConstants.taskCollection.doc(docId).update({
        'name': name,
        'userId': userId,
        'employNaId': employNaId,
        'startDateStringFormat': startDateStringFormat,
        'endDateStringFormat': endDateStringFormat,
        'startDate': startDate,
        'endDate': endDate,
        'taskName': taskName,
      });
      return 'done';
    } catch (e) {
      return 'error';
    }
  }

  ///
  static Future<String> addAdministrativeCircular({
    required String text,
    required String file,
    required String title,
  }) async {
    try {
      await AppConstants.administrativeCircularCollection.add({
        'text': text,
        'file': file,
        'title': title,
        'createdOn': FieldValue.serverTimestamp(),
      });
      return 'done';
    } catch (e) {
      return 'error';
    }
  }

  static Future<String> updateAdministrativeCircular({
    required String text,
    required String title,
    required String file,
    required String docId,
  }) async {
    try {
      await AppConstants.administrativeCircularCollection.doc(docId).update({
        'text': text,
        'title': title,
        'file': file,
      });
      return 'done';
    } catch (e) {
      return 'error';
    }
  }
}
