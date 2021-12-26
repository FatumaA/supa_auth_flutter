import 'package:flutter/material.dart';
import 'package:supa_auth_flutter/ui-elements/email_only_field_form.dart';

class MagicLinkAuth extends StatelessWidget {
 const  MagicLinkAuth({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SupaFlutter Auth'),
      ),
      body: const EmailOnlyFieldForm(
        titleText: 'Enter an Email',
      ),
    );
  }
}
