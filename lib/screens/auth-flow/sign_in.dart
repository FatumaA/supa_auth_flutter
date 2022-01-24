import 'package:flutter/material.dart';
import 'package:supa_auth_flutter/screens/auth-flow/other_providers.dart';
import 'package:supa_auth_flutter/ui-elements/form.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SupaFlutter Auth'),
      ),
      body: Column(
        children: [
          const AuthForm(
            titleText: 'Sign In',
          ),
          OtherProviders(
            contextText: 'Sign In',
          )
        ],
      ),
    );
  }
}
