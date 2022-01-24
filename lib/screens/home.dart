import 'package:flutter/material.dart';
import 'package:supa_auth_flutter/utils/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map? googleData;
  User? activeUser = SupabaseHelper().getActiveUser();
  Session? activeSession = SupabaseHelper().getActiveSession();

  @override
  void initState() {
    print(activeSession);
    // TODO: implement initState
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      // Future.delayed(Duration(seconds: 2));
      // print(googleData?["resSocial"]);
      print(activeUser);
      print('object');
      if (activeSession == null || activeUser == null) {
        Navigator.popAndPushNamed(context, '/');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    if (args != null) googleData = args as Map;
    return Scaffold(
      appBar: AppBar(
        title: const Text('SupaFlutter Auth'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Karibu! You are logged In successfully',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 40,
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
