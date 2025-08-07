import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const NubankCloneApp());
}

class NubankCloneApp extends StatelessWidget {
  const NubankCloneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nubank Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const HomeScreen(),
    );
  }
}
