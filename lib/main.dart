import 'package:flutter/material.dart';
import 'mapping.dart';
import 'authentication.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MappingPage(
        authenticate: Auth(),
      ),
    );
  }
}
