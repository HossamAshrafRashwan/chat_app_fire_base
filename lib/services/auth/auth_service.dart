import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService extends ChangeNotifier {
  //instance of authenticator
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // instance for fire store
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // sign user in
  Future<UserCredential> signInWithEmailandPassword(
    String email,
    String password,
  ) async {
    try {
      // sign in
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // add a new document for the user in users collection if it doesn't exists
      _firestore.collection("users").doc(userCredential.user!.uid).set(
        {
          "uid": userCredential.user!.uid,
          "email": email,
        },
        SetOptions(
          merge: true,
        ),
      );

      return userCredential;
    }
    // catch any errors
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // Create a user
  Future<UserCredential> signUpWithEmailandPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // create user document in the user collection, after creating the user
      _firestore.collection("users").doc(userCredential.user!.uid).set({
        "uid": userCredential.user!.uid,
        "email": email,
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // sing user out
  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}
