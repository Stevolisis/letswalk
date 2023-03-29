import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

typedef TT = Function(String error, String stackTrace);

class AuthenticationRepository {
  static final _dio = Dio();

  static firebase_auth.FirebaseAuth get _firebaseAuth =>
      firebase_auth.FirebaseAuth.instance;

  static Stream<firebase_auth.User?> get user {
    return _firebaseAuth.authStateChanges();
  }

  static Future<void> login(String regNo, String password) async {
    validateData(dynamic data) {
      if ((data as Map).containsKey('token')) {
        return data['token'];
      } else {}
    }

    T validateStatusAndData<T>(Response<T> resp) {
      switch (resp.statusCode) {
        case 200:
          return validateData(resp.data);
        case 401:
          throw Exception();
        default:
          throw Exception();
      }
    }

    final response = await asyncTry(
      () async {
        return await _dio.post(
          'https://ping2.onrender.com/login',
          data: {'regNo': '18/000155U/2', 'password': '12345'},
        );
      },
      (error, stackTrace) {},
    );

    final c = validateStatusAndData(response);
    try {
      await _firebaseAuth.signInWithCustomToken(c as String);
    } on firebase_auth.FirebaseAuthException catch (e) {
      switch (e.code) {
        
      }
    }
  }

  Future logOut() async {}

  static Future<T> asyncTry<T>(Future<T> Function() reg, [TT? cb]) async {
    try {
      return await reg();
    } catch (_) {
      throw cb?.call('', '');
    }
  }
}
