import 'package:flutter/material.dart';
import 'package:github_client/pages/wrapper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gihub Client',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Wrapper(title: 'Github Client Home Page'),
    );
  }
}
