import 'package:flutter/material.dart';
import 'package:habit_tracker/screen/database/habit_database.dart';
import 'package:habit_tracker/screen/view/home_screen.dart';
import 'package:habit_tracker/screen/provider/theme_provider.dart';
import 'package:provider/provider.dart';

Future<void> main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  // initialize database
  await HabitDatabase.initialize();
  await HabitDatabase.saveFirstLaunchDate();


  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => HabitDatabase(),),
      ChangeNotifierProvider(create: (context) => ThemeProvider(),),
    ],
    child: const MyApp(),)
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home_Screen(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}

