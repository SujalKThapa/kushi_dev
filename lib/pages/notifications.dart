import 'package:flutter/material.dart';

class User_Notification extends StatefulWidget {
  const User_Notification({super.key});

  @override
  State<User_Notification> createState() => _User_NotificationState();
}

class _User_NotificationState extends State<User_Notification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          "Notifications",

        ),
      ),
    );
  }
}
