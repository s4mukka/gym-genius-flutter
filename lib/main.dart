import 'package:flutter/material.dart';
import 'package:gymgenius/views/home_view.dart';
import 'package:gymgenius/utils/colors.dart';
// import 'package:nubank/views/home/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GymGenius',
      theme: ThemeData(
        primarySwatch: getMaterialColor(Colors.white),
        scaffoldBackgroundColor: backgroundColor,
        textButtonTheme: TextButtonThemeData(style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return blueLight;
            }
            return blue;
          }),
          textStyle: MaterialStateProperty.all(
            const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold, )
          )
        ),)
      ),
      home: const HomeView() //const HomeView()
    );
  }
}
