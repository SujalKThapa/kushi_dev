
import 'package:flutter/material.dart';
import 'package:kushi_3/pages/mainactivity.dart';
import 'package:kushi_3/themes/dark_mode.dart';
import 'package:kushi_3/themes/light_mode.dart';
import 'package:kushi_3/model/globals.dart' as globals;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
        title: "flutter demo",
      
        theme: lightMode,
        darkTheme: darkMode,

      home: MainActivity(namey: globals.userName,),
    );
  }
}
