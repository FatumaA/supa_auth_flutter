import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseHelper {
  Future createNewUser(String email, String password) async {
    final res = await Supabase.instance.client.auth.signUp(email, password);
    final user = res.data?.user;
    final error = res.error;
    print(res.data);
  }

  Future signInExistingUser(String email, String password) async {
    final res = await Supabase.instance.client.auth.signIn(
      email: email,
      password: password,
    );
    final user = res.data?.user;
    final error = res.error;
    print(res);
  }

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
  User getActiveUser() {
    final user = Supabase.instance.client.auth.user();
    if (user != null) {
      return user;
    }
    throw Exception('Couldn\'t get active user, user null');
  }

  createNewProfileForActiveUser(Map uData) async {
    print(uData);
    final res = await Supabase.instance.client.from('profiles').insert([
      {
        'id': uData['id'],
        'name': uData['uName'],
        'email': uData['uEmail'],
      }
    ]).execute();
    print(res.error);
  }

  // Upload img to storage bucket
  // uploadProfileAvatar(entireFile) async {
  //   final storageResponse = await Supabase.instance.client
  //     .storage
  //     .from('public')
  //     .upload( entireFile['name'], entireFile);

  //     print(storageResponse.error);
  //     print(storageResponse.data);
  // }
} 