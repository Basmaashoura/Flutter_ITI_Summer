import 'package:flutter/material.dart';
import 'chats.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData( scaffoldBackgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,
      home: Chats(),
    );
  }
}
