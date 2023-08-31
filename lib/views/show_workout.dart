import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gymgenius/repositories/workout_repository.dart';
import 'package:gymgenius/utils/colors.dart';

class ShowWorkoutView extends StatefulWidget {
  final String workoutName;
  const ShowWorkoutView({super.key, required this.workoutName});

  @override
  State<ShowWorkoutView> createState() => _ShowWorkoutViewState();
}

class _ShowWorkoutViewState extends State<ShowWorkoutView> {
  Workout? workout;
  final Image noImage = Image.asset("lib/assets/logo.png");

  @override
  void initState() {
    super.initState();
    _fetchWorkout();
  }

  void _fetchWorkout() async {
    Workout newWorkout = await const WorkoutRepository().showWorkout(widget.workoutName);
    setState(() {
      workout = newWorkout;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SingleChildScrollView(
        child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    workout!.workoutName,
                    style: const TextStyle(
                      color: blueDark,
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ),
              ),
              Column(
                children: workout!.exercises.map((exercise) {
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
