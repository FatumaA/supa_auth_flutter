import 'package:flutter/material.dart';

class AlertUI extends StatefulWidget {
  final String headerText, bodyText, closeAlertBtnText;

  const AlertUI({
    Key? key,
    required this.headerText,
    required this.bodyText,
    required this.closeAlertBtnText,
  }) : super(key: key);

  @override
  State<AlertUI> createState() => _AlertUIState();
}

class _AlertUIState extends State<AlertUI> {
  final _formKey = GlobalKey<FormState>();
  final _token = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _token.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(16),
      backgroundColor: Colors.grey[800],
      title: Text(
        widget.headerText,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.white70,
        ),
      ),
      content: Text(
        widget.bodyText,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.white60,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            widget.closeAlertBtnText,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
