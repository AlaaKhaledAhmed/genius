import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Widget/AppConstants.dart';

class Database {
  //=======================Student Sing up method======================================

  static Future<String> addEmploy({
    required String name,
    required String email,
    required String section,
    required String phone,
    required double salary,
    required String contract,
    required String employNaId,
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
          'contract':contract,
          'employNaId':employNaId,
          'type':'employ'
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
    required double salary,
    required String contract,
    required String employNaId,
    required String docId,
  }) async {
    try {
      await AppConstants.userCollection.doc(docId).update(
          {
            'name': name,
            'section': section,
            'phone': phone,
            'salary': salary,
            'contract':contract,
            'employNaId':employNaId,
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

//===================================================================
  static Future<String> resetPassword({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.trim());
      return 'done';
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        return 'user-not-found';
      }
    } catch (e) {
      return 'error';
    }
    return 'error';
  }
}
