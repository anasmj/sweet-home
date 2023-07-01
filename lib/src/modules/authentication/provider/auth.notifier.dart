import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sweet_home/src/api/auth.service.dart';
import 'package:sweet_home/src/providers/selected.home.provider.dart';

import '../../../model/app.user.dart';

final appUserNotifier = NotifierProvider<AppUserProvider, Stream<AppUser?>>(
  AppUserProvider.new,
);

class AppUserProvider extends Notifier<Stream<AppUser?>> {
  GlobalKey<FormState> loginFormKey = GlobalKey();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool showLogin = true;
  AppUser newAppUser = AppUser();
  AppUser? currentUser;
  final registrationFormKey = GlobalKey<FormState>();

  @override
  Stream<AppUser?> build() {
    Stream<AppUser?> userStream = _auth.userChanges().map(toAppUserModel);
    userStream.first.then((appUser) {
      ref.read(selectedHomeProvider.notifier).searchAndSetUserHome();
    });
    return userStream;
  }

  AppUser? toAppUserModel(User? user) {
    if (user != null) {
      currentUser = AppUser(
        userId: user.uid,
        email: user.email,
        name: _auth.currentUser!.displayName,
      );
      return currentUser;
    } else {
      return null;
    }
  }

  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount? get user => _user;

  Future<bool> onLogin() async {
    if (loginFormKey.currentState != null) {
      if (!loginFormKey.currentState!.validate()) return false;
    }
    final res = await AuthService().signInWithEmailAndPass(
      email: newAppUser.email!,
      password: newAppUser.password!,
    );
    return res.code == 200;
  }

  Future<void> signInWithGoogle() async {
    // await AuthService().signInWithEmailAndPass();
    // final googleUser = await googleSignIn.signIn();
    // if (googleUser == null) return;
    // _user = googleUser;

    // final googleAuth = await googleUser.authentication;
    // final credential = GoogleAuthProvider.credential(
    //   accessToken: googleAuth.accessToken,
    //   idToken: googleAuth.idToken,
    // );
    // await _auth.signInWithCredential(credential);
  }
  Future<void> onLogout() async {
    await AuthService().logOut();
  }

  void onNameChange(String s) {
    newAppUser.name = s;
  }

  void onEmailChange(String s) {
    newAppUser.email = s;
  }

  void onPassChange(String s) {
    newAppUser.password = s;
  }

  Future<void> register() async {
    if (registrationFormKey.currentState!.validate()) {
      // print(newAppUser.name);
      // print(newAppUser.email);
      // print(newAppUser.password);

      await AuthService().registerWithEmailAndPass(
        email: newAppUser.email!,
        password: newAppUser.password!,
        userName: newAppUser.name,
      );
    }
  }
}
