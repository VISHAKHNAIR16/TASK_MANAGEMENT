import 'package:flutter/material.dart';
import 'package:task_management/Pages/home_screen.dart';


void main()
{
  return runApp(MyApp());
}


class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeScreen(),);
  }

}