import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sweet_home/src/model/app.user.dart';
import 'package:sweet_home/src/model/response.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Response response = Response();

  //create user object
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

  //stream
  Stream<AppUser?> get appUserStream {
    return _auth.userChanges().map(toAppUserModel);
    // return _auth.userChanges().map((User? user) => toAppUserModel(user));
  }

  // CREATE NEW USER
  Future<Response> registerWithEmailAndPass({
    required String email,
    required String password,
    String? userName = 'Unnamed',
  }) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? firebaseUser = userCredential.user;

      //setting up firestore for the new users
      await _db.collection('users').doc(firebaseUser!.uid).set({
        'UserName': userName,
        'Email': email,
        'Password': password,
      }).then((value) {
        firebaseUser.updateDisplayName(userName);
        response.code = 200;
        response.body = 'User created successfully';
        // response.user = toAppUserModel(firebaseUser);
      });
    } catch (e) {
      response.code = 400;
      response.body = e.toString();
    }
    return response;
  }

  //sign in ann

  Future<Response> signInAnon() async {
    try {
      // final userCredential = await _auth.signInAnonymously();
      response.code = 200;
      response.body = 'user found';
      // response.user = toAppUserModel(userCredential.user);
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
  Future<Response> signInWithEmailAndPass({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      User? firebaseUser = userCredential.user;
      print(firebaseUser?.email);
      response.code = 200;
      response.body = 'New user created ';
      //return this somehow
      toAppUserModel(firebaseUser);
    } catch (e) {
      response.code = 400;
      response.body = e.toString();
    }
    return response;
  }

  //sign out
  Future<Response> logOut() async {
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
