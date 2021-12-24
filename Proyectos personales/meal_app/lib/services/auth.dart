import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expireDate;
  String? _userId;

  bool get isAuth => _token != null;

  get token {
    if (_token != null &&
        _expireDate != null &&
        _expireDate!.isAfter(DateTime.now())) {
      return _token!;
    }
    return null;
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyAwGVREySmeRwErh2SIbhO-ctiQcUWFLcw');
    final res = await http.post(url,
        body: jsonEncode(
            {'email': email, 'password': password, 'returnSecureToken': true}));
    final responseData = jsonDecode(res.body);
    print(responseData);
  }
}
