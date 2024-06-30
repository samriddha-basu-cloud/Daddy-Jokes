import 'package:flutter/material.dart';
import 'joke_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daddy Jokes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: JokePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
