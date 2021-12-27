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
                validator: widget.titleText !=
                        'Enter your email address/phone to reset your password'
                    ? (value) {
                        if (value == null ||
                            value.isEmpty ||
                            !EmailValidator.validate(_email.text)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      }
                    : (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 4) {
                          return 'Contact field must be valid and not empty';
                        }
                        return null;
                      },
                decoration: InputDecoration(
                  icon: const Icon(Icons.email),
                  border: const OutlineInputBorder(),
                  hintText: widget.titleText ==
                          'Enter your email address/phone to reset your password'
                      ? 'Enter your contact'
                      : 'Enter your email',
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
                            'Enter your email address/phone to reset your password'
                        ? 'Send Reset Link'
                        : 'Send Magic Link',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate() &&
                        widget.titleText ==
                            'Enter your email address/phone to reset your password') {
                      final res = await SupabaseHelper()
                          .resetExistingUserPassword(_email.text,
                              'http://localhost:53463/#/reset-password-dialog');
                              print(res.rawData);
                      _email.text = '';
                      if (res.error == null) {
                        await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertUI(
                              headerText: 'Passoword reset link sent!',
                              bodyText:
                                  'Please check your email/phone to continue',
                              closeAlertBtnText: 'Got it',
                            );
                          },
                        );
                      }

                      // Navigator.popAndPushNamed(context, '/home');
                      else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertUI(
                              headerText: 'Oops! Something went wrong',
                              bodyText: res.error!.message,
                              closeAlertBtnText: 'Got it',
                            );
                          },
                        );
                      }

                      _email.text = '';
                      // throw Exception(e.toString());

                    } else {
                      final res = await SupabaseHelper()
                          .createNewPasswordlessUser(_email.text);
                      if (res.error?.message == null) {
                        await showDialog(
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
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertUI(
                              headerText: 'Oops! Something went wrong',
                              bodyText: res.error!.message,
                              closeAlertBtnText: 'Got it',
                            );
                          },
                        );
                        _email.text = '';
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
                  style: const TextStyle(fontWeight: FontWeight.bold),
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
