import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart' as dio;

class TextInputData extends StateNotifier<String> {
  TextInputData(super.state);

  void onChanged(String value) => state = value;
}

final regNoProvider =
    StateNotifierProvider<TextInputData, String>((_) => TextInputData(''));
final passwordProvider =
    StateNotifierProvider<TextInputData, String>((_) => TextInputData(''));

login(String regNo, String password) async {
  try {
    final uri = Uri.https('letswalk.vercel.app', '/login');

    final client = dio.Dio();

    final resp = await client.post(
      'https://letswalk.vercel.app/login',
      options: dio.Options(contentType: 'application/json'),
      data: jsonEncode({'regNo': regNo, 'password': password}),
    );
    // final resp = await client.post(
    //   uri,
    //   body: body,
    //   headers: {"Content-Type": "application/json"},
    // );
    log('here $uri ${resp.statusCode}');
    switch (resp.statusCode) {
      case 200:
        log('successful');
        break;
      case 401:
        log('failed');
        break;
    }
  } on dio.DioError catch (e) {
    log(e.toString());
    // rethrow;
  }
}
