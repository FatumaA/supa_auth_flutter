import 'package:flutter/material.dart';
import 'package:supa_auth_flutter/ui-elements/forgot_password_form.dart';



class ForgotPassword extends StatelessWidget {
  const ForgotPassword({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SupaFlutter Auth'),
      ),
      body: const ForgotPasswordForm(
        titleText: 'Enter your email address to reset your password',
      ),
    );
  }
}