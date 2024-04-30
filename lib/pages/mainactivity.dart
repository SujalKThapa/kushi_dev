import 'package:flutter/material.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:line_icons/line_icons.dart';

import 'Fragments/mainFragments/Profile_Fragment.dart';
import 'Fragments/mainFragments/actvity_fragment.dart';
import 'Fragments/mainFragments/group_fragment.dart';
import 'Fragments/mainFragments/home_fragment.dart';

class MainActivity extends StatefulWidget {
  final dynamic namey;

  const MainActivity({
    super.key,
    required this.namey,
  });

  @override
  State<MainActivity> createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {

  String? profileImageUrl;
  String profileName = 'suhas';
  int _selectedIndex = 0;

  static  final List<Widget> _widgetOptions = <Widget>[
    HomeFragment(),

    ActivityFragment(),
    GroupFragment(),
    ProfileFragment(namey: 'suhas'),


  ];




  @override
  Widget build(BuildContext context) {
    DateTime _now = DateTime.now();
    String formattedDate = DateFormat('d MMM').format(_now);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 90,
        title: Center(
          child: Column(
            children: [
              Text(
                'Hello, $profileName',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Today $formattedDate',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ),
        leading: _buildUserProfileAvatar(),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Handle IconButton press
            },
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                color: Colors.white,
              )
            ]
        ),
        child: SafeArea(


          child: GNav(
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.black,
            tabBackgroundColor:Colors.white,

            rippleColor: Colors.white,
            hoverColor: Colors.white,
            gap: 5,
            iconSize: 24,



            tabs: const [
              GButton(icon: LineIcons.home),
              GButton(icon :Icons.auto_graph_outlined),
              GButton(icon: Icons.groups_3),
              GButton(icon:Icons.person),
              // GButton(icon: Icons.person_outline),
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



  Widget _buildUserProfileAvatar() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: profileImageUrl != null
              ? CachedNetworkImage(
            imageUrl: profileImageUrl!,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.cover,
            width: 50,
            height: 50,
          )
              : Image.asset(
            'assets/mario.jpg',
            fit: BoxFit.cover,
            width: 50,
            height: 50,
          ),
        ),
      ),
    );
  }
}

// enum _SelectedTab { home, favorite, search, person }
