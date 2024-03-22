import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:kushi_3/pages/notifications.dart';

class MainActivity extends StatefulWidget {
  String namey;
  MainActivity({required this.namey, super.key});

  @override
  State<MainActivity> createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {
  late String name;
  @override
   void initState() {
    super.initState();
    name = widget.namey; // Accessing namey from the widget instance
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.all(20.0),
              color: Theme.of(context).colorScheme.background,
              child: Row(
                children: [
                  Text(
                    'Hello ',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            blurRadius: 2.0,
                            color: Theme.of(context).colorScheme.primary,
                            offset: Offset(2.0, 2.0),
                          )
                        ]),
                  ),
                  Text(
                    name,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 40.0),
                  ),
                  SizedBox(
                    width: 70,
                  ),
                  GestureDetector(
                    child: Icon(
                      Icons.notifications,
                      size: 35,
                    ),
                    onTap: (){
                       Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NotificationPage()));
                    },
                  )
                ],
              ),
            ),
            // Your other widgets here
          ],
        ),
        bottomNavigationBar: GNav(
          backgroundColor: Theme.of(context).colorScheme.background,
          color: Theme.of(context).colorScheme.primary,
          activeColor: Theme.of(context).colorScheme.background,
          tabBackgroundColor: Theme.of(context).colorScheme.primary,
          onTabChange: (value) {},
          gap: 0,
          tabs: [
            const GButton(
              icon: Icons.home_outlined,
              // text: "home"
            ),
            const GButton(
              icon: Icons.person_2_outlined,
              // text: "home"
            ),
            const GButton(
              icon: Icons.home,
              // text: "home"
            ),
            const GButton(
              icon: Icons.home,
              // text: "home"/
            ),
            const GButton(
              icon: Icons.home,
              // text: "home"/
            ),
          ],
        ));
  }
}
