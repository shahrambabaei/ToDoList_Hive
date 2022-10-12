import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
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
          inputDecorationTheme: const InputDecorationTheme(
              border: InputBorder.none,
              hintStyle: TextStyle(color: ColorTheme.secondaryTextColor),
              prefixIconColor: ColorTheme.secondaryTextColor),
          colorScheme: const ColorScheme.light(
              primary: ColorTheme.primaryColor,
              secondary: ColorTheme.secondaryColor,
              onSecondary: ColorTheme.onsecondaryColor),
          textTheme: GoogleFonts.poppinsTextTheme(const TextTheme(
              headline6: TextStyle(
                  fontSize: 22,
                  color: ColorTheme.onPrimaryColor,
                  fontWeight: FontWeight.w500),
              bodyText1: TextStyle(
                  fontSize: 18,
                  color: ColorTheme.primaryTextColor,
                  fontWeight: FontWeight.w500)))),
      home: HomeScreen(task: Task()),
    );
  }
}
