import 'package:flutter/material.dart';
import 'package:ipm1920_p2/navigation/navigation_pages.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        //primaryColor: Color(0xffE8175D),
        primaryColor: Colors.red,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      title: 'Flutter Demo',
      routes: {
        WorkoutsPage.routeName : (context) => WorkoutsPage(),
        ExercisesPage.routeName : (context) => ExercisesPage(),
        ExercisesInfoPage.routeName : (context) => ExercisesInfoPage(),
        TrainingPage.routeName : (context) => TrainingPage(),
      },
      initialRoute: WorkoutsPage.routeName,
    );
  }
}



