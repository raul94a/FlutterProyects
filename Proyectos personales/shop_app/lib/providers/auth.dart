import 'dart:async';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter_complete_guide/models/http_exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expireDate;
  String _userId;
  Timer _authTimer;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_token != null &&
        _expireDate != null &&
        _expireDate.isAfter(DateTime.now())) {
      return _token;
    }
    return null;
  }

  String get user => _userId;

  void logout() {
    _token = null;
    _userId = null;
    _expireDate = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }

    notifyListeners();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpire = _expireDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpire), logout);
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyAwGVREySmeRwErh2SIbhO-ctiQcUWFLcw';
    final Uri uri = Uri.parse(url);

    final res = await http.post(uri,
        body: jsonEncode(
            {'email': email, 'password': password, 'returnSecureToken': true}));
    final responseData = jsonDecode(res.body);
    print(responseData);
    if (responseData['error'] != null) {
      var err = 'ERROR: ${responseData['error']['message']}';
      print(err);
      throw HttpException(err);
    }
    _token = responseData['idToken'];
    _userId = responseData['localId'];
    _expireDate = DateTime.now()
        .add(Duration(seconds: int.parse(responseData['expiresIn'])));
    _autoLogout();
    notifyListeners();
    //store token
    final prefs = await SharedPreferences.getInstance();
    final userData = jsonEncode({
      'token': _token,
      'userId': _userId,
      'expireDate': _expireDate.toIso8601String(),
    });
    print('DATOS GUARDADOS: $userData');
    await prefs.setString('userData', userData);
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<bool> tryAutoLogin() async {
    print('COMPROBANDO AUTOLOGIN');
    final prefs = await SharedPreferences.getInstance();
    print('prefs: $prefs');
    if (!prefs.containsKey('userData')) {
      print('no continee user data');
      return false;
    }
    final extractedUserData = jsonDecode(prefs.getString('userData'));
    final expireDate = DateTime.parse(extractedUserData['expireDate']);
    print('OBTENIENDO LOS DATOS: $extractedUserData');
    if (expireDate.isBefore(DateTime.now())) {
      print('expire date superior');
      return false;
    }
    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _expireDate = expireDate;
    print('Datos extraidos: \n $_token');

    notifyListeners();
    _autoLogout();
    return true;
  }
}
