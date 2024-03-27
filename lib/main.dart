import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:kushi_3/pages/signin.dart';
import 'package:kushi_3/themes/dark_mode.dart';
import 'package:kushi_3/themes/light_mode.dart';
import 'package:kushi_3/model/globals.dart' as globals;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures all plugins are initialized
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); // Asynchronously initialize Firebase
  runApp(MyApp()); // Run your application
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

      home: SignIn(),
    );
  }
}
