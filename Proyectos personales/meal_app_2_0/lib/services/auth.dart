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
    if (responseData['error'] != null) {
      throw HttpException(responseData['error']['message']);
    }
    //seteamos las variables...
    _token = responseData['idToken'];
    _expireDate = DateTime.now()
        .add(Duration(seconds: int.parse(responseData['expiresIn'])));
    _userId = responseData['localId'];
    notifyListeners();
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }
}

class HttpException implements Exception {
  String message;
  HttpException(this.message);
  @override
  String toString() {
    // TODO: implement toString
    return message;
  }
}
