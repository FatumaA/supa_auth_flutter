import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseHelper {
  final supaClient = Supabase.instance.client;
  // email-password sign up
  Future<GotrueSessionResponse> createNewUser(
      String email, String password) async {
    final res = await supaClient.auth.signUp(email, password);

    return res;
  }

  // email-password sign in
  Future<GotrueSessionResponse> signInExistingUser(
      String email, String ? password) async {
    final res = await supaClient.auth.signIn(
      email: email,
      password: password,
    );

    return res;
  }

  // phone auth with password and verification step
  Future<GotrueSessionResponse> createNewPhoneUser(
      String phone, String password) async {
    final res = await supaClient.auth.signUpWithPhone(phone, password);
    // signUpWithPhone(phone, password);
    return res;
  }

  Future<GotrueSessionResponse> verifyPhoneUser(
      String phone, String token) async {
    final res = await supaClient.auth.verifyOTP(
      phone,
      token,
      options: AuthOptions(redirectTo: 'http://localhost:53463/home'),
    );
  
    return res;
  }

  Future<GotrueSessionResponse> signInUserWithPhone(
      String phone, String password) async {
    final res = await supaClient.auth.signIn(
      phone: phone,
      password: password,
    );

    return res;
  }

  // email magic link sign in
  Future<GotrueSessionResponse> createNewPasswordlessUser(String email) async {
    final res = await supaClient.auth.signIn(
      email: email,
    );

    return res;
  }

  // social login with Google
  Future<bool> signInWithGoogle() async {
    final res = await supaClient.auth.signInWithProvider(
      Provider.google,
      options: AuthOptions(redirectTo: 'http://localhost:53463/home', 
      scopes: '')
      
  // scopes: 'repo gist notifications',
      // AuthOptions(redirectTo: 'http://localhost:53463/home'
      // //  kIsWeb
      // //     ? null
      // //     : 'io.supabase.flutter://reset-callback/'
      //     ),
    );

    return res;
  }

  // sign out active user
  Future<GotrueResponse> signOutActiveUser() async {
    final res = await supaClient.auth.signOut();

    return res;
  }

  // sends user a reset password email, redirectTo - screen user comes back to
  Future<GotrueJsonResponse> resetExistingUserPassword(
      String email, String? urlPath) async {
    final res = await supaClient.auth.api.resetPasswordForEmail(
      email,
      options: AuthOptions(
        redirectTo: urlPath,
      ),
    );

    return res;
  }

  Future<GotrueUserResponse> updateUserPassword(
      String accessToken, String password) async {
    final res = await supaClient.auth.api.updateUser(
      accessToken,
      UserAttributes(password: password),
    );

    //  final res = await Supabase.instance.client.auth.update(
    //     UserAttributes(data: {'password': password})
    // );

    return res;
  }

  // get active user
  User? getActiveUser() {
    final user = supaClient.auth.user();

    return user;
  }

  Session? getActiveSession() {
    // Future.delayed(Duration(seconds: 2));
    final sessionOne = supaClient.auth.currentSession; 
    // .session();
    // onAuthStateChange((event, session) {
    //    async (event, session) => {
    //      print('SESSION: ${session}'),
    //   };
    // });
    print('${sessionOne?.user?.id}');

    return sessionOne;
  }

  Future<GotrueSessionResponse> getOauth2Session(Uri url) async {
    final res = await supaClient.auth.getSessionFromUrl(url);
    print('get Session from url : ${res.data?.user}');
    return res;
  }
}
