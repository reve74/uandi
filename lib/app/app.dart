import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uandi/app/model/couple.dart';
import 'package:uandi/app/screen/home_screen.dart';
import 'package:uandi/app/screen/select_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: App(),
    );
  }
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box<Couple>('couple').listenable(),
        builder: (context, Box<Couple> box, child) {
          final item = box.get(0);
          if(item == null) {
            return SelectScreen();
          }
          return HomeScreen();
    });
  }
}
