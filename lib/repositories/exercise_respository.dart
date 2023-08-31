import 'dart:convert';

import 'package:http/http.dart' as http;

class Exercise {
  final int id;
  final String name;
  final String image;

  const Exercise({
    required this.id,
    required this.name,
    this.image = '',
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "image": image,
    };
  }
}

class ExerciseRepository {
  const ExerciseRepository();

  Future<List<Exercise>> findExercise(String term) async {
    final queryParams = {
      'language': 'pt-BR',
      'term': term
    };

    final response = await http
      .get(
        Uri.https('wger.de', '/api/v2/exercise/search', queryParams),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

    if (response.statusCode == 200) {
      List<Exercise> exercises = jsonDecode(response.body)['suggestions'].map<Exercise>(
        (exercise) => Exercise(
            id: exercise['data']['id'],
            name: exercise['data']['name'],
            image: exercise['data']['image'] ?? '',
        )
      ).toList();

      return exercises;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Falha na busca de exercícios!');
    }
  }
}
