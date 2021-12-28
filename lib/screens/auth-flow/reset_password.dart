import 'package:flutter/material.dart';
import 'package:supa_auth_flutter/ui-elements/verifications_alert.dart';

class ResetPasswordDialog extends StatefulWidget {
  const ResetPasswordDialog({Key? key}) : super(key: key);

  @override
  _ResetPasswordDialogState createState() => _ResetPasswordDialogState();
}

class _ResetPasswordDialogState extends State<ResetPasswordDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('SupaFlutter Auth'),
          automaticallyImplyLeading: false,
        ),
        body: VerificationsAlertUI(headerText: 'Reset Password'));
  }
}
