import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gymgenius/repositories/exercise_respository.dart';
import 'package:gymgenius/repositories/workout_repository.dart';
import 'package:gymgenius/utils/colors.dart';
import 'package:gymgenius/views/add_exercise.dart';

class NewWorkoutView extends StatefulWidget {
  const NewWorkoutView({super.key});

  @override
  State<NewWorkoutView> createState() => _NewWorkoutViewState();
}

class _NewWorkoutViewState extends State<NewWorkoutView> {
  final List<Exercise> exercises = [];
  final TextEditingController _workoutNameController = TextEditingController();
  final Image noImage = Image.asset("lib/assets/logo.png");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SingleChildScrollView(
        child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        controller: _workoutNameController,
                        decoration: const InputDecoration(
                          hintText: 'Nome do Treino',
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextButton(
                        onPressed: () {
                          Workout workout = Workout(
                            workoutName: _workoutNameController.text,
                            exercises: exercises
                          );
                          const WorkoutRepository().createWorkout(context, workout);
                        },
                        child: const Text('Adicionar')
                      )
                    )
                  )
                ],
              ),
              Column(
                children: exercises.map((exercise) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Container(
                          alignment: AlignmentDirectional.center,
                          height: 100,
                          decoration: const BoxDecoration(
                            color: blue,
                            borderRadius: BorderRadius.all(Radius.circular(8))
                          ),
                          child: Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: Container(
                                  width: double.infinity,
                                  child: Image.network(
                                    'http://wger.de${exercise.image}',
                                    loadingBuilder: (context, child, loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      } else {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    },
                                    errorBuilder: (context, error, stackTrace) => noImage,
                                  )
                                )
                              ),
                              Flexible(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Text(
                                    exercise.name,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 13.0,
                                      fontFamily: 'Roboto',
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                )
                              ),
                            ]
                          ),
                        ),
                      )
                    ),
                  );
                }).toList(),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: DottedBorder(
                  color: blue,
                  strokeWidth: 2,
                  dashPattern: const [6, 3],
                  padding: const EdgeInsets.all(0),
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () async {
                        Exercise addedExercise = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AddExerciseView()),
                        );

                        setState(() {
                          exercises.add(addedExercise);
                        });
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: blue,
                        backgroundColor: Colors.transparent,
                      ),
                      child: const Text('Adicionar Exercício'),
                    )
                  )
                )
              )
            ],
          )
      ),
    );
  }

  PreferredSize _appBar(){
    return PreferredSize(
      preferredSize: const Size.fromHeight(0),
      child: AppBar(
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
    );
  }
}
