import 'package:flutter/material.dart';

class AlertUI extends StatelessWidget {

  String headerText, bodyText, closeAlertBtnText;

  AlertUI({
    Key? key,
    required this.headerText,
    required this.bodyText,
    required this.closeAlertBtnText,
  }) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(16),
      backgroundColor: Colors.grey[800],
      title: Text(
        headerText,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.white70,
        ),
      ),
      content: Text(
        bodyText,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.white60,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            closeAlertBtnText,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
