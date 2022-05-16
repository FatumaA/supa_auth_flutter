import 'package:flutter/material.dart';
import 'package:supa_auth_flutter/ui-elements/form.dart';

import 'other_providers.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SupaFlutter Auth'),
      ),
      body: Column(
        children: const [
          AuthForm(
            titleText: 'Sign Up',
          ),
          OtherProviders(contextText: 'Sign Up'),
        ],
      ),
    );
  }
}
