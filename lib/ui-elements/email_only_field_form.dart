import 'package:flutter/material.dart';
import 'package:supa_auth_flutter/utils/supabase.dart';
import 'package:email_validator/email_validator.dart';

import 'alert.dart';

class EmailOnlyFieldForm extends StatefulWidget {
  final String titleText;
  const EmailOnlyFieldForm({Key? key, required this.titleText})
      : super(key: key);

  @override
  _EmailOnlyFieldFormState createState() => _EmailOnlyFieldFormState();
}

class _EmailOnlyFieldFormState extends State<EmailOnlyFieldForm> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 800,
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.titleText,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
              TextFormField(
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !EmailValidator.validate(_email.text)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  icon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                  hintText: 'Enter your email',
                ),
                style: const TextStyle(
                  color: Colors.white,
                ),
                controller: _email,
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  child: Text(
                    widget.titleText ==
                            'Enter your email address to reset your password'
                        ? 'Send Reset Email'
                        : 'Sign Up',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate() &&
                        widget.titleText ==
                            'Enter your email address to reset your password') {
                      try {
                        SupabaseHelper()
                            .resetExistingUserPassword(_email.text, '/home');
                        _email.text = '';
                      } catch (e) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertUI(
                              headerText: 'Oops! Something went wrong',
                              bodyText: e.toString(),
                              closeAlertBtnText: 'Got it',
                            );
                          },
                        );
                        _email.text = '';
                        // throw Exception(e.toString());
                      }
                    } else {
                      try {
                        SupabaseHelper().createNewPasswordlessUser(_email.text);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertUI(
                              headerText: 'Verification link sent!',
                              bodyText:
                                  'Please check your email to verify and continue',
                              closeAlertBtnText: 'Got it',
                            );
                          },
                        );
                        _email.text = '';
                      } catch (e) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertUI(
                              headerText: 'Oops! Something went wrong',
                              bodyText: e.toString(),
                              closeAlertBtnText: 'Got it',
                            );
                          },
                        );
                        _email.text = '';
                        // throw Exception(e.toString());
                      }
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                child: Text(
                  widget.titleText ==
                          'Enter your email address to reset your password'
                      ? 'Remembered your password? Sign In'
                      : '',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
