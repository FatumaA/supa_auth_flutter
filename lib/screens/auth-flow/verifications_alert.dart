import 'package:flutter/material.dart';
import 'package:supa_auth_flutter/utils/supabase.dart';

import '../../ui-elements/alert.dart';

var supabaseHelper = SupabaseHelper();

class VerificationsAlertUI extends StatefulWidget {
  // String headerText;
  // String? phone, ctxText;

  const VerificationsAlertUI({Key? key}) : super(key: key);

  @override
  State<VerificationsAlertUI> createState() => _VerificationsAlertUIState();
}

class _VerificationsAlertUIState extends State<VerificationsAlertUI> {
  Map? data;
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
    var args = ModalRoute.of(context)?.settings.arguments;
    if (args != null) data = args as Map;
    return Scaffold(
      appBar: AppBar(
        title: const Text('SupaFlutter Auth'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Container(
          width: 800,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  data != null ? data!["headerText"] : 'Reset Password',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 6) {
                          return data?["headerText"] != 'Reset Password'
                              ? 'Entered the wrong verification code'
                              : 'Password can\'t be empty and must be atleast 6 characters long';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        icon: const Icon(Icons.lock),
                        prefixStyle: const TextStyle(color: Colors.white),
                        border: const OutlineInputBorder(),
                        hintText: data?["headerText"] != 'Reset Password'
                            ? 'Enter your verfification code'
                            : 'Enter new password',
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      controller: _token,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate() &&
                              data?["headerText"] != 'Reset Password') {
                            final res = await supabaseHelper.verifyPhoneUser(
                                data?["phone"], _token.text);
                            if (res.user != null) {
                              await Navigator.popAndPushNamed(context, '/home');
                              // Navigator.pop(context);
                            } else {
                              return showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const AlertUI(
                                    headerText: 'Error',
                                    bodyText: 'No user found',
                                    closeAlertBtnText: 'Got it',
                                  );
                                },
                              );
                            }
                            _token.text = '';
                          } else {
                            final res = await supabaseHelper.updateUserPassword(
                                Uri.base.queryParameters["access_token"]
                                    .toString(),
                                _token.text);
                            if (res.user != null) {
                              Navigator.popAndPushNamed(context, '/home');
                              //  Navigator.pop(context);
                            } else {
                              return showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const AlertUI(
                                    headerText: 'Error',
                                    bodyText: 'User not found',
                                    closeAlertBtnText: 'Got it',
                                  );
                                },
                              );
                            }
                            _token.text = '';
                          }
                        },
                        child: Text(
                          data?["headerText"] != 'Reset Password'
                              ? 'Reset Password'
                              : 'Verify',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
