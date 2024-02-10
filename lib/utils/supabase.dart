import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseHelper {
  final supaClient = Supabase.instance.client;

  // email-password sign up
  Future<AuthResponse> createNewUser(String email, String password) async {
    final res = await supaClient.auth.signUp(email: email, password: password);

    return res;
  }

  // email-password sign in
  Future<AuthResponse> signInExistingUser(String email, String password) async {
    final res = await supaClient.auth.signInWithPassword(
      email: email,
      password: password,
    );

    return res;
  }

  // phone auth with password sign-up and verification step
  Future<AuthResponse> createNewPhoneUser(String phone, String password) async {
    final res = await supaClient.auth.signUp(
      phone: phone,
      password: password,
    );

    return res;
  }

  Future<AuthResponse> verifyPhoneUser(String phone, String token) async {
    final res = await supaClient.auth.verifyOTP(
      phone: phone,
      token: token,
      type: OtpType.sms,
    );

    return res;
  }

//sign-in phone user
  Future<AuthResponse> signInUserWithPhone(
      String phone, String password) async {
    final res = await supaClient.auth.signInWithPassword(
      phone: phone,
      password: password,
    );

    return res;
  }

  // email magic link sign-in/up
  Future<void> createMagicLinkUser(String email) async {
    final res = await supaClient.auth.signInWithOtp(
      email: email,
    );

    return res;
  }

  // social login with Google
  Future<bool> signInWithGoogle() async {
    final res = await supaClient.auth.signInWithOAuth(
      OAuthProvider.google,
    );

    return res;
  }

  // sign out active user
  Future<void> signOutActiveUser() async {
    final res = await supaClient.auth.signOut();

    return res;
  }

  // sends user a reset password email, redirectTo - screen user comes back to
  Future<void> resetExistingUserPassword(String email, String? urlPath) async {
    final res = await supaClient.auth.resetPasswordForEmail(
      email,
    );

    return res;
  }

  Future<UserResponse> updateUserPassword(
      String accessToken, String password) async {
    final res = await supaClient.auth.updateUser(
      UserAttributes(data: {'password': password}),
    );

    return res;
  }

  // get active user
  User? getActiveUser() {
    final user = supaClient.auth.currentUser;

    return user;
  }
}
