import 'package:flutter/material.dart';
import 'package:fssp_snakegame/splash_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SNAKE GAME',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.pinkAccent,
        hintColor: Colors.lightGreenAccent,
      ),
      home: SplashScreen(),
    );
  }

  
}
