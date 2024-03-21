import 'package:flutter/material.dart';

class NotificationItem extends StatelessWidget {
  final String title;
  final String message;
  final String formattedDate; // Updated to include formatted date

  const NotificationItem({
    Key? key,
    required this.title,
    required this.message,
    required this.formattedDate, // Updated to include formatted date
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(message),
      trailing: Text(formattedDate),
    );
  }
}