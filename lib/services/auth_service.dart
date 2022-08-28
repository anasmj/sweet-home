import 'package:firebase_auth/firebase_auth.dart';
import 'package:sweet_home/models/response.dart';

import '../models/app_user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Response response = Response();

  //create user object
  AppUser? toAppUserModel(User? user) {
    if (user != null) {
      return AppUser(userId: user.uid);
    }
    return null;
  }

  //stream
  Stream<AppUser?> get appUserStream {
    return _auth.userChanges().map(toAppUserModel);
    // return _auth.userChanges().map((User? user) => toAppUserModel(user));
  }

  //sign in ann

  Future<Response> signInAnon() async {
    try {
      final userCredential = await _auth.signInAnonymously();
      response.code = 200;
      response.body = 'user found';
      response.user = toAppUserModel(userCredential.user);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          response.code = 400;
          response.body =
              "Anonymous auth hasn't been enabled for this project.";

          break;
        default:
          response.code = 400;
          response.body = "Unknown error.";
      }
    }
    return response;
  }
  //sign in with email and pass

  //register with email and pass
  Future<Response> registerWithEmailAndPass(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? firebaseUser = userCredential.user;
      response.code = 200;
      response.body = 'New user created ';
      response.user = toAppUserModel(firebaseUser);
    } catch (e) {
      response.code = 400;
      response.body = e.toString();
    }
    return response;
  }

  //sign out

  Future signOut() async {
    try {
      await _auth.signOut();
      response.code = 200;
      response.body = 'signed out';
      return response;
    } catch (e) {
      response.code = 400;
      response.body = 'error occured';
      return response;
    }
  }
}
