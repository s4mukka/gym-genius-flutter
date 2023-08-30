import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gymgenius/utils/colors.dart';

class WorkoutsView extends StatefulWidget {
  const WorkoutsView({super.key});

  @override
  State<WorkoutsView> createState() => _WorkoutsViewState();
}

class _WorkoutsViewState extends State<WorkoutsView> {
  final List<String> workouts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SingleChildScrollView(
        child: Column(
            children: [
              Column(
                children: workouts.map((string) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: (){},
                        child: Text(string),
                      ),
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
                      onPressed: (){
                        setState(() {
                          workouts.add('teste');
                        });
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: blue,
                        backgroundColor: Colors.transparent,
                        // backgroundColor: MaterialStateProperty.all(Colors.transparent),
                        // textStyle: MaterialStateProperty.all(
                        //   const TextStyle(fontSize: 20, color: blue)
                        // )
                      ),
                      child: const Text('Adicionar Treino'),
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
