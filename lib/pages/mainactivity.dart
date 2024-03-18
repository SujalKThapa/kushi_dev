import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainActivity extends StatefulWidget {
  const MainActivity({super.key});

  @override
  State<MainActivity> createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: GNav(
          tabs: [
            GButton(
              icon: Icons.home,
              text: "home"
            ),
            GButton(
              icon: Icons.home,
              text: "home"
            ),
            GButton(
              icon: Icons.home,
              text: "home"
            ),
            GButton(
              icon: Icons.home,
              text: "home"
            ),

          ],
        )

    );
  }
}