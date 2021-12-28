import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseHelper {
  // email-password sign up
  Future<GotrueSessionResponse> createNewUser(
      String email, String password) async {
    final res = await Supabase.instance.client.auth.signUp(email, password);

    return res;
  }

  // phone auth with password and verification step
  Future<GotrueSessionResponse> createNewPhoneUser(
      String phone, String password) async {
    final res =
        await Supabase.instance.client.auth.signUpWithPhone(phone, password);
    // signUpWithPhone(phone, password);
    return res;
  }

  Future<GotrueSessionResponse> verifyPhoneUser(
      String phone, String token) async {
    final res = await Supabase.instance.client.auth.verifyOTP(
      phone,
      token,
      options: AuthOptions(redirectTo: 'http://localhost:53463/home'),
    );

    return res;
  }

  Future<GotrueSessionResponse> signInUserWithPhone(
      String phone, String password) async {
    final res = await Supabase.instance.client.auth
        .signIn(phone: phone, password: password);
    // .signIn(phone: phone, password: password);
    print(res.error);
    return res;
  }

  // email-password sign in
  Future<GotrueSessionResponse> signInExistingUser(
      String email, String password) async {
    final res = await Supabase.instance.client.auth.signIn(
      email: email,
      password: password,
    );

    return res;
  }

  // email magic link sign in
  Future<GotrueSessionResponse> createNewPasswordlessUser(String email) async {
    final res = await Supabase.instance.client.auth.signIn(
      email: email,
      options: AuthOptions(redirectTo: 'http://localhost:53463/home'),
    );

    return res;
  }

  // social login with Google
  Future<bool> signInWithGoogle() async {
    final res = await Supabase.instance.client.auth.signInWithProvider(
      Provider.google,
      options: AuthOptions(redirectTo: 'http://localhost:53463/home'),
    );
    // signInWithProvider(
    //   Provider.google,
    //   options: AuthOptions(redirectTo: 'http://localhost:53463/home'),
    // );

    return res;
  }

  // sign out active user
  Future<GotrueResponse> signOutActiveUser() async {
    final res = await Supabase.instance.client.auth.signOut();

    return res;
  }

  // sends user a reset password email, redirectTo - screen user comes back to
  Future<GotrueJsonResponse> resetExistingUserPassword(
      String email, String? urlPath) async {
    final res = await Supabase.instance.client.auth.api.resetPasswordForEmail(
      email,
      options: AuthOptions(
        redirectTo: urlPath,
      ),
    );

    return res;
  }

  Future<GotrueUserResponse> updateUserPassword(String accessToken, String password) async {
    final res = await Supabase.instance.client.auth.api.updateUser(
      accessToken,
      UserAttributes(password: ''),
    );

    return res;
  }

  // get active user
  User? getActiveUser() {
    final user = Supabase.instance.client.auth.currentUser;
    print('user: $user');

    return user;
  }
}
