import 'package:flutter/material.dart';
import 'package:supa_auth_flutter/utils/supabase.dart';
import 'package:email_validator/email_validator.dart';


class ForgotPasswordForm extends StatefulWidget {
  final String titleText;
  const ForgotPasswordForm({Key? key, required this.titleText})
      : super(key: key);

  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
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
                child: ElevatedButton(
                  child: const Text(
                    'Send Reset Email',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate() &&
                        widget.titleText == 'Sign In') {
                      try {
                        SupabaseHelper()
                            .resetExistingUserPassword(_email.text, '/home');
                      } catch (e) {
                        throw Exception(e.toString());
                      }
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                child: const Text('Remembered your password? Sign In'),
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
