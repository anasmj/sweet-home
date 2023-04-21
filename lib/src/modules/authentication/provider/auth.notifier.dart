import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../model/app.user.dart';

final authNotifier =
    NotifierProvider<AppUserNotifier, Stream<AppUser?>>(AppUserNotifier.new);

class AppUserNotifier extends Notifier<Stream<AppUser?>> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool showLogin = true;
  AppUser newAppUser = AppUser();
  final registrationFormKey = GlobalKey<FormState>();
  @override
  Stream<AppUser?> build() => _auth.userChanges().map(toAppUserModel);

  AppUser? toAppUserModel(User? user) {
    if (user != null) {
      return AppUser(
        userId: user.uid,
        email: user.email,
        name: _auth.currentUser!.displayName,
      );
    }
    return null;
  }

  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount? get user => _user;

  Future<void> googeLogin() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _auth.signInWithCredential(credential);
  }

  Future<void> logout() async {
    googleSignIn.disconnect();
    _auth.signOut();
  }

  void onNameChange(String s) {
    newAppUser.name = s;
  }

  void onEmailChange(String s) {
    newAppUser.name = s;
  }

  void onPassChange(String s) {
    newAppUser.name = s;
  }

  Future<void> register() async {
    print(newAppUser.email);
    print(newAppUser.name);
    // if (registrationFormKey.currentState!.validate()) {
    // Response response =
    //     await AuthService().registerWithEmailAndPass(
    //   email: _emailController.text,
    //   password: _passController.text,
    //   userName: _nameController.text,
    // );
    // if (response.code != 200) {
    //   // ignore: use_build_context_synchronously
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     AppWidget.showSnackBarWithMsg(
    //         msg: response.body ??
    //             'Unknown error occured '),
    //   );
    // }
  }
}
