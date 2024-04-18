import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:kushi_3/pages/Fragments/mainFragments/group_fragment.dart';
import 'package:kushi_3/pages/Fragments/mainFragments/home_fragment.dart';
import 'package:kushi_3/pages/Fragments/mainFragments/screen_1.dart';
import 'package:kushi_3/pages/notifications.dart';
import 'package:kushi_3/pages/profilePage.dart';
import 'package:kushi_3/model/globals.dart' as globals;
import 'package:kushi_3/pages/Fragments/mainFragments/Profile_Fragment.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

class MainActivity extends StatefulWidget {
  dynamic namey;
  MainActivity({required this.namey, super.key});

  @override
  State<MainActivity> createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {

  int _selectedIndex = 0;

  static  final List<Widget> _widgetOptions = <Widget>[
    HomeFragment(),
    ContactPage(),

    ActivityPage(),
    Container(color: Colors.red,),
    Profile_Fragment(namey: globals.userName),


  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    color: Colors.black.withOpacity(0.1),
                  )
                ]
              ),
            child: SafeArea(

                // padding: EdgeInsets.symmetric(horizontal: 15,vertical: 8),
                child: GNav(
                  backgroundColor: Theme.of(context).colorScheme.background,
                  color: Theme.of(context).colorScheme.primary,
                  activeColor: Theme.of(context).colorScheme.background,
                  tabBackgroundColor: Theme.of(context).colorScheme.primary,

                  rippleColor: Colors.black,
                  hoverColor: Colors.black,
                  gap: 8,
                  iconSize: 24,


                  tabs: [
                    GButton(icon: LineIcons.home),
                    GButton(icon: Icons.group_add_outlined),
                    GButton(icon: LineIcons.home),
                    GButton(icon: LineIcons.home),
                    GButton(icon: Icons.person_outline),
                  ],
                  selectedIndex: _selectedIndex,
                  onTabChange: (index){
                    setState(() {
                      _selectedIndex=index;
                    });
                  },

                ),


            ),
          ),
    );
  }

}
