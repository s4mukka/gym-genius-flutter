import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gymgenius/views/home_view.dart';
import 'package:gymgenius/views/workouts_view.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class User {
  final String username;
  final String password;

  const User({
    required this.username,
    this.password = '',
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "password": password
    };
  }
}

class UserRepository {
  const UserRepository();

  Future<bool> createUser(BuildContext context, User user) async {
    final response = await http
      .post(
        Uri.parse('http://10.0.2.2:8000/user/create'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(user.toJson())
      );

    if (response.statusCode == 200) {
      if (context.mounted) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const HomeView()),
        );
      }
      return true;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Falha na criação de usuário!');
    }
  }

  Future<void> login(BuildContext context, User user) async {
    final response = await http
      .post(
        Uri.parse('http://10.0.2.2:8000/user/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(user.toJson())
      );

    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Map<String, dynamic> body = jsonDecode(response.body);
      prefs.setString('token', '${body['token_type']} ${body['access_token']}');
      if (context.mounted) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const WorkoutsView()),
        );
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Falha na criação de usuário!');
    }
  }
}
