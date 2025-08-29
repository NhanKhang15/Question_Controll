import 'package:flutter/material.dart';
import 'package:frontend/Admin/homepage/AminHomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: Tracking(),
      // home: SignupScreen(),
      title: 'Quản lý câu hỏi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF5AA6FF), // xanh chủ đạo (như ảnh)
        scaffoldBackgroundColor: const Color(0xFFF8FAFF),
        fontFamily: 'Roboto',
      ),
      // home: const QuestionHomePage(),
      home: HomePage(),
    );
  }
}
