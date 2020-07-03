import 'package:flutter/material.dart';
import 'home/pages/home_page.dart';
import '../di/injection_container.dart' as di;

void main() async{
  await di.init();
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(homeBloc: di.sl()),
    );
  }
}

