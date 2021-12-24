import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseHelper {
  // email-password sign up
  Future createNewUser(String email, String password) async {
    final res = await Supabase.instance.client.auth.signUp(email, password);
    final user = res.data?.user;
    final error = res.error;
    print(res.data);
  }

  // phone auth with password and verification step
  Future createNewPhoneUser(String phone, String password) async {
    final res =
        await Supabase.instance.client.auth.signUpWithPhone(phone, password);
    final user = res.data?.user;
    final error = res.error;
    print(res.data);
  }

  Future verifyPhoneUser(String phone, String token) async {
    final res = await Supabase.instance.client.auth.verifyOTP(phone, token);
    final user = res.data?.user;
    final error = res.error;
    print(res.data);
  }

  Future signInUserWithPhoneUser(String phone, String password) async {
    final res = await Supabase.instance.client.auth
        .signIn(phone: phone, password: password);
    final user = res.data?.user;
    final error = res.error;
    print(res.data);
  }

  // email-password sign in
  Future signInExistingUser(String email, String password) async {
    final res = await Supabase.instance.client.auth.signIn(
      email: email,
      password: password,
    );
    final user = res.data?.user;
    final error = res.error;
    print(res);
  }

  // email magic link sign in
  Future createNewPasswordlessUser(String email) async {
    final res = await Supabase.instance.client.auth.signIn(
      email: email,
    );
    final user = res.data?.user;
    final error = res.error;
    print(res);
  }

  // social login with Google
  Future signInWithGoogle() async {
    // final res =
    await Supabase.instance.client.auth.signInWithProvider(Provider.google);

    // print(res);
  }

  // sign out active user
  Future signOutActiveUser() async {
    final res = await Supabase.instance.client.auth.signOut();
    final error = res.error;
  }

  // sends user a reset password email, redirectTo - screen user comes back to
  Future resetExistingUserPassword(String email, String? urlPath) async {
    final res = await Supabase.instance.client.auth.api.resetPasswordForEmail(
      email,
      options: AuthOptions(
        redirectTo: urlPath,
      ),
    );

    final error = res.error;
  }

  // get active user
  User? getActiveUser() {
    final user = Supabase.instance.client.auth.user();
    if (user != null) {
      return user;
    }
    return null;
    // throw Exception('Couldn\'t get active user, user null');
  }
}
