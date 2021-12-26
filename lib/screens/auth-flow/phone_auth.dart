import 'package:flutter/material.dart';
import 'package:supa_auth_flutter/ui-elements/alert.dart';
import 'package:supa_auth_flutter/utils/supabase.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({Key? key}) : super(key: key);

  @override
  _PhoneAuthState createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  final _formKey = GlobalKey<FormState>();
  final _phone = TextEditingController();
  final _password = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _phone.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SupaFlutter Auth'),
      ),
      body: Center(
        child: Container(
          width: 800,
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Sign Up With Phone',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 4) {
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    icon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                    hintText: 'Enter your phone number including country code',
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  controller: _phone,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 6) {
                      return 'Please enter a password that is atleast 6 characters long';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    icon: Icon(Icons.lock),
                    prefixStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(),
                    hintText: 'Enter your password',
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  controller: _password,
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          await SupabaseHelper().createNewPhoneUser(_phone.text, _password.text);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertUI(
                                phone: _phone.text,
                                headerText: 'Enter your verification code',
                                bodyText: '',
                                closeAlertBtnText: '',
                              );
                            },
                          );
                          _phone.text = '';
                          _password.text = '';
                          Navigator.pushNamed(context, '/home');
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
                  child: const Text(
                    'Take me back to Sign In Screen',
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
      ),
    );
  }
}
