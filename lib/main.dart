import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supa_auth_flutter/screens/auth-flow/forgot_password.dart';
import 'package:supa_auth_flutter/screens/auth-flow/sign_in.dart';
import 'package:supa_auth_flutter/screens/auth-flow/sign_up.dart';
import 'package:supa_auth_flutter/screens/home.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'],
    anonKey:
        dotenv.env['SUPABASE_ANON_KEY'],
  );
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
      title: 'Mapumziko',
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
        '/home': (context) => Home(),
      },
    );
  }
}