import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist_hive/config/color_theme.dart';
import 'package:todolist_hive/model/task.dart';
import 'package:todolist_hive/screens/home_screen.dart';

const taskBoxName = 'taskName';
void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(PriorityAdapter());
  await Hive.openBox<Task>(taskBoxName);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: ColorTheme.primaryContainerColor));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: const ColorScheme.light(
              primary: ColorTheme.primaryColor,
              secondary: ColorTheme.secondaryColor,
              onSecondary: ColorTheme.onsecondaryColor)),
      home: const HomeScreen(),
    );
  }
}
