import 'package:flutter/material.dart';
import 'package:supa_auth_flutter/utils/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  User? activeUser = SupabaseHelper().getActiveUser();

  @override
  Widget build(BuildContext context) {
    if (activeUser?.aud != 'authenticated') {
      Navigator.popAndPushNamed(context, '');
    }
      // print(activeUser);
    return Scaffold(
      appBar: AppBar(
        title: const Text('SupaFlutter Auth'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          children: [
            const Text(
              'Karibu! You are logged In successfully',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
            ),
            const SizedBox(
              height: 100,
            ),
            TextButton(
              onPressed: () async {
                await SupabaseHelper().signOutActiveUser();
                Navigator.pop(context, '/');
              },
              child: const Text(
                'Sign Out',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            )
          ],
        ),
      ),
    );
  }
}
