import 'package:calculator_app/Screen/calcu.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme=ThemeData(
   useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: Colors.blueGrey),
    textTheme: GoogleFonts.latoTextTheme(),
);

void main() {
  runApp(const Calculator());
}

class Calculator extends StatelessWidget{
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
   return MaterialApp(
    theme:theme,
    home: Scaffold(
      appBar: AppBar(
        backgroundColor:const Color.fromARGB(255, 231, 216, 221),
        title:  Text('Calculator',
        style:Theme.of(context).textTheme.titleLarge,),
      ),
    body: const CalcuScreen(),
    ),
   );
  }
}

