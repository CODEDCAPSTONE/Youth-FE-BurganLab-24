import 'dart:io';
import 'package:flutter/material.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/services/auth.dart';
import 'package:frontend/services/client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  String? token;
  User? user;
  double? balance;
  List? transactions;

  Future<Map<String, dynamic>> signup(Map<String, dynamic> submitedInfo) async {
    var response = await AuthServices().signup(
      user: User(
        username: submitedInfo['username'], 
        password: submitedInfo['password'],
        phoneNumber: submitedInfo['phoneNumber'],
        email: submitedInfo['email']
      )
    );
    if (response['token'] != null) {
      _setToken(submitedInfo['username'], response['token']!);
    }
    // print(response['token'] ?? 'No token');
    notifyListeners();
    return response;
  }

  Future<Map<String, dynamic>> signin({required String username, required String password}) async {
    // print(username);
    // print(password);
    var response = await AuthServices().signin(user: User(username: username, password: password));
    // balance = double.parse(response['balance'].toString());
    if (response['token'] != null) {
      _setToken(username, response['token']!);
    }
    // print(token);
    notifyListeners();
    return response;
  }

  Future getBalance() async {
    var response = await AuthServices().getBalance();
    // balance = double.parse(response['balance'].toString());
    notifyListeners();
  }

  Future getTransactions() async {
    var response = await AuthServices().getTransactions();
    transactions = response["transactions"];
    notifyListeners();
  }

  bool isAuth() {
    // print(user ?? 'No User');
    // print(token ?? 'No token');
    return (user != null && token != null);
  }

  Future<void> initAuth() async {
    // print("initAuth");
    await _getToken();
    if (isAuth()) {
      Client.dio.options.headers = {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      };
      user = User(username: user!.username, password: token);
      // print('Bearer $token');
      notifyListeners();
    }
  }

  void _setToken(String username, String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.token = token; 
    user = User(username: username, password: token);
    prefs.setString("username", username);
    prefs.setString("token", token);
    notifyListeners();
  }

  Future<void> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var username = prefs.getString("username");
    var token = prefs.getString("token");

    if (username == null || token == null) return;

    user = User(username: username, password: token);
    this.token = token;
    notifyListeners();
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('username');
    prefs.remove('token');
    user = null;
    notifyListeners();
  }
}
