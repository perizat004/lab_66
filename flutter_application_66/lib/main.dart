import 'package:flutter/material.dart';
import 'registration_page.dart'; // Басқа бір файлдан RegistrationPage классын енгізу.

void main() {
  runApp(MyApp()); // Flutter қосымшасын іске қосу.
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Қосымшада debug жалауы көрінбейді.
      title: 'Registration Form', // Қосымшаның атауы.
      theme: ThemeData(
        primarySwatch:
            Colors.blue, // Қосымшаның тақырыбы көк түспен белгіленеді.
      ),
      home:
          RegistrationPage(), // Қосымша іске қосылған кезде көрсетілетін бет (бастапқы бет) – RegistrationPage.
    );
  }
}
