import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supa_auth_flutter/screens/auth-flow/forgot_password.dart';
import 'package:supa_auth_flutter/screens/auth-flow/sign_in.dart';
import 'package:supa_auth_flutter/screens/auth-flow/sign_up.dart';
import 'package:supa_auth_flutter/screens/home.dart';
import 'package:supa_auth_flutter/screens/auth-flow/verifications_alert.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_strategy/url_strategy.dart';

import 'screens/auth-flow/magic_link_auth.dart';
import 'screens/auth-flow/phone_auth.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'],
    anonKey: dotenv.env['SUPABASE_ANON_KEY'],
    authCallbackUrlHostname: 'http://localhost:53463/home',
  );
  setPathUrlStrategy();
  runApp(
   const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Supa Auth Flutter',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.teal,
        textTheme: GoogleFonts.nunitoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SignIn(),
        '/sign-up': (context) => const SignUp(),
        '/forgot-password': (context) => const ForgotPassword(),
        '/magic-link': (context) => const MagicLinkAuth(),
        '/phone-auth': (context) => const PhoneAuth(),
        '/verification': (context) => VerificationsAlertUI(),
        '/home': (context) => const Home(),
      },
    );
  }
}

// http://localhost:53463/#/ 
// flutter run -d chrome --web-port=1234