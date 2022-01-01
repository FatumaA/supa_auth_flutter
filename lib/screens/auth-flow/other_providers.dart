import 'package:flutter/material.dart';
import 'package:supa_auth_flutter/ui-elements/alert.dart';
import 'package:supa_auth_flutter/utils/supabase.dart';

class OtherProviders extends StatefulWidget {
  String contextText;

  OtherProviders({Key? key, required this.contextText}) : super(key: key);

  @override
  _OtherProvidersState createState() => _OtherProvidersState();
}

class _OtherProvidersState extends State<OtherProviders> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 800,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Divider(),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Or...',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          GridView.count(
            crossAxisCount: 3,
            childAspectRatio: 4.5,
            crossAxisSpacing: 20,
            shrinkWrap: true,
            children: [
              ElevatedButton(
                onPressed: () async {
                  final res = await SupabaseHelper().signInWithGoogle();
                  await Future.delayed(const Duration(seconds: 2));
                  if (res != true) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertUI(
                          headerText: 'Something went wrong',
                          bodyText: 'error',
                          closeAlertBtnText: 'Ok',
                        );
                      },
                    );
                  } else {
                    Navigator.popAndPushNamed(context, '/home',
                        arguments: {"resSocial": res});
                  }
                },
                child: Text(
                  widget.contextText == 'Sign In'
                      ? 'Sign in With Google'
                      : 'Sign up With Google',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/phone-auth',
                    arguments: {"ctxText": widget.contextText},
                  );
                },
                child: Text(
                  widget.contextText == 'Sign In'
                      ? 'Sign in With Phone'
                      : 'Sign up With Phone',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/magic-link',
                  );
                },
                child: Text(
                  widget.contextText == 'Sign In'
                      ? 'Passwordless Sign In'
                      : 'Passwordless Sign Up',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
