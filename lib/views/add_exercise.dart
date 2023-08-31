import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gymgenius/repositories/exercise_respository.dart';
import 'package:gymgenius/utils/colors.dart';

class AddExerciseView extends StatefulWidget {
  const AddExerciseView({super.key});

  @override
  State<AddExerciseView> createState() => AddExerciseViewState();
}

class AddExerciseViewState extends State<AddExerciseView> {
  List<Exercise> exercises = [];
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
                          hintText: 'Pesquisar...',
                        ),
                        onChanged: (String value) async {
                          List<Exercise> newExercises = await const ExerciseRepository().findExercise(value);
                          setState(() {
                            exercises.clear();
                            exercises.addAll(newExercises);
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: exercises.map((exercise) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SizedBox(
                      width: double.infinity,
                      child: InkWell(
                        onTap: (){
                          Navigator.pop(context, exercise);
                        },
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
                    ),
                  );
                }).toList(),
              ),
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
