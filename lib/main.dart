import 'package:flutter/material.dart';
import 'package:weather_app/weather_screen.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      home: const WeatherScreen(),
    );
  }
}


//layout principals
//  CONSTRAINTS GO DOWN - boundries
//  SIZES GO UP - widget tries to expand all the area
//  PARENTS SETS POSITION - arranging its children