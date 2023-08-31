import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gymgenius/repositories/exercise_respository.dart';
import 'package:gymgenius/views/home_view.dart';
import 'package:gymgenius/views/workouts_view.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Workout {
  final String workoutName;
  final List<Exercise> exercises;

  const Workout({
    required this.workoutName,
    this.exercises = const [],
  });

  factory Workout.fromJson(Map<String, dynamic> json) {
    print(json);
    return Workout(
      workoutName: json['workoutName'],
      exercises: json['exercises'].map<Exercise>((exercise) => Exercise(
        id: exercise['id'],
        name: exercise['name'],
        image: exercise['image'],
      )).toList()
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "workoutName": workoutName,
      "exercises": exercises.map((exercise) => exercise.toJson()).toList()
    };
  }
}

class WorkoutRepository {
  const WorkoutRepository();

  Future<void> createWorkout(BuildContext context, Workout workout) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    print(jsonEncode(workout.toJson()));
    final response = await http
      .post(
        Uri.parse('http://10.0.2.2:8000/workout/create'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': token,
        },
        body: jsonEncode(workout.toJson())
      );

    if (response.statusCode == 200) {
      if (context.mounted) {
        Navigator.of(context).pop();
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Falha na criação do treino!');
    }
  }

  Future<Workout> showWorkout(String workoutName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    final response = await http
      .get(
        Uri.parse('http://10.0.2.2:8000/workout/$workoutName'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': token,
        }
      );

    if (response.statusCode == 200) {
      return Workout.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Falha na criação do treino!');
    }
  }

  Future<List<Workout>> listWorkouts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    final response = await http
      .get(
        Uri.parse('http://10.0.2.2:8000/workout'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': token,
        }
      );

    if (response.statusCode == 200) {
      return jsonDecode(response.body).map<Workout>((workout) => Workout.fromJson(workout)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Falha na criação do treino!');
    }
  }
}
