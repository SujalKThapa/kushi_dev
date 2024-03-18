
import 'package:flutter/material.dart';
import 'package:kushi_3/pages/selectHeight.dart';
import 'package:kushi_3/pages/selectWeight.dart';
import 'package:kushi_3/themes/dark_mode.dart';
import 'package:kushi_3/themes/light_mode.dart';

import 'pages/introslider.dart';
import 'pages/selectGender.dart';

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

      home: const IntroSlider(),
    );
  }
}
