import 'package:flutter/material.dart';
import 'package:weather_api/home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Api',
      theme: ThemeData(),
      home:  HomePage(),
    );
  }
}

