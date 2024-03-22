import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:kushi_3/pages/notifications.dart';
import 'package:kushi_3/model/globals.dart' as globals;
import 'package:kushi_3/components/settingButtons.dart';


class profilePage extends StatefulWidget {
  String namey;
  profilePage({required this.namey, super.key});

  @override
  State<profilePage> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
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
          mainAxisAlignment: MainAxisAlignment.start,
          children:[
            SizedBox(height: 60, ),
            Text("Profile", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
            SizedBox(height: 25, ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Stack(
                
                      children: <Widget>[
                        Container(
                          width: 140, // Adjust according to your needs
                          height: 140, // Adjust according to your needs
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [Colors.redAccent, Colors.lightBlueAccent], // Example gradient colors
                              begin: Alignment.topRight, // Example gradient begin alignment
                              end: Alignment.bottomLeft,
                              stops: [0.2, 0.8]// Example gradient end alignment
                            ), // Change color according to your needs
                          ),
                        ),
                        // Square profile image
                        Positioned(
                          left: 10,
                          top: 10,
                          child: Container(
                            width: 120, // Adjust according to your needs
                            height: 120, // Adjust according to your needs
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 15.0), // Circular border
                            ),
                            child: ClipOval(
                              child: Image.asset("assets/sujal.png",
                                  width: 150, // Adjust according to your needs
                                height: 150, // Adjust according to your needs
                                fit: BoxFit.cover),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 75,),
                    VerticalDivider(
                      color: Colors.black,
                      thickness: 1,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 50.0, left: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Joined"),
                            Text("2 months ago", style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5,),
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left:20.0),
                  child: Text(globals.userName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),),
                )
            ),
            const SizedBox(height: 30,),
            settingButton(
                text: "Edit profile",
                onTap: () => () {}
            ),
            const SizedBox(height: 30,),
            settingButton(
                text: "Privacy profile",
                onTap: () => () {}
            ),
            const SizedBox(height: 30,),
            settingButton(
                text: "Settings",
                onTap: () => () {}
            ),

          ]
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
