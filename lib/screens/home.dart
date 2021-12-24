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
    if (activeUser == null) {
      Navigator.pop(context, '/');
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('SupaFlutter Auth'),
      ),
      body: Center(
        child: Column(
          children: [
            const Text(
              'Karibu! You are logged In successfully',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(
              height: 100,
            ),
            TextButton(
              onPressed: () {
                SupabaseHelper().signOutActiveUser();
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
