import 'package:flutter/material.dart';
import 'package:gymgenius/utils/colors.dart';

class Button extends StatefulWidget {
  const Button({super.key});

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (){},
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return blueLight;
          }
          return blue;
        }),
        textStyle: MaterialStateProperty.all(
          TextStyle(fontSize: 20, color: Colors.white.withOpacity(1.0))
        )
      ),
      child: const Text('teste'),
    );
  }
}
