import 'package:flutter/material.dart';
import 'package:supa_auth_flutter/utils/supabase.dart';

import 'alert.dart';

class VerificationsAlertUI extends StatefulWidget {
  String headerText;
  String? phone, ctxText;

  VerificationsAlertUI({Key? key, required this.headerText, this.phone})
      : super(key: key);

  @override
  State<VerificationsAlertUI> createState() => _VerificationsAlertUIState();
}

class _VerificationsAlertUIState extends State<VerificationsAlertUI> {
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
    return AlertDialog(
        contentPadding: const EdgeInsets.all(16),
        backgroundColor: Colors.grey[800],
        title: Text(
          widget.headerText,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.white70,
          ),
        ),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 6) {
                    return widget.headerText != 'Reset Password'
                        ? 'Entered the wrong verification code'
                        : 'Password can\'t be empty and must be atleast 6 characters long';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.lock),
                  prefixStyle: const TextStyle(color: Colors.white),
                  border: const OutlineInputBorder(),
                  hintText: widget.headerText != 'Reset Password'
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
                        widget.headerText != 'Reset Password') {
                      final res = await SupabaseHelper()
                          .verifyPhoneUser(widget.phone!, _token.text);
                      print(res);
                      if (res.user?.aud == 'authenticated') {
                        print(res.user?.aud);
                        //  Navigator.popAndPushNamed(context, '/home');
                        Navigator.pop(context);
                      } else {
                        return showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertUI(
                              headerText: 'Error',
                              bodyText: res.error!.message,
                              closeAlertBtnText: 'Got it',
                            );
                          },
                        );
                      }
                      _token.text = '';
                    } else {
                      print('QUERY PARAMS: ${Uri.base.queryParameters["access_token"]}');
                      final res = await SupabaseHelper()
                          .updateUserPassword(Uri.base.queryParameters["access_token"].toString(), _token.text);
                      print(res);
                      if (res.error?.message != null) {
                        print(res.user?.aud);
                        Navigator.popAndPushNamed(context, '/home');
                        //  Navigator.pop(context);
                      } else {
                        return showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertUI(
                              headerText: 'Error',
                              bodyText: res.error!.message,
                              closeAlertBtnText: 'Got it',
                            );
                          },
                        );
                      }
                      _token.text = '';
                    }
                  },
                  child: Text(
                    widget.headerText != 'Reset Password' ? 'Verify' : 'Reset Password',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
