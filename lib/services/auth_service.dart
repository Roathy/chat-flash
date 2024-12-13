import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:fluttertoast/fluttertoast.dart';

enum AuthStatus {
  error,
  loading,
  success,
}

class AuthService {
  Future<AuthStatus?> signup({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      String message = 'oops! something went wrong!';
      if (e.code == 'email-already-in-use') {
        message = 'An account already exists with that email.';
      }
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 15,
      );
    } catch (e) {
      print(e);
      return AuthStatus.error;
    }
    return null;
  }

  Future<dynamic> login({
    required String email,
    required String password,
  }) async {
    try {
      final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return user;
    } on FirebaseAuthException catch (e) {
      String message = 'oops! something went wrong ${e.message}';
      Fluttertoast.showToast(msg: message);
    } catch (e) {
      print(e);
    }
  }
}
