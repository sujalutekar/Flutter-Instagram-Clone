import 'package:flutter/material.dart';

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../resources/storage_methods.dart';
import '../models/user.dart' as model;

class AuthMethods with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // getting user details

  Future<model.User> getUserDetails() async {
    User currentUser = _firebaseAuth.currentUser!;

    DocumentSnapshot snap =
        await _firebaseFirestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }

  // sign up user

  Future<UserCredential> signUpUser(
    String email,
    String password,
    String username,
    String bio,
    Uint8List file,
  ) async {
    try {
      UserCredential _userCred =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String photoUrl = await StorageMethods()
          .uploadImageToStorage('profilePics', file, false);

      model.User user = model.User(
        bio: bio,
        email: email,
        followers: [],
        following: [],
        uid: _userCred.user!.uid,
        username: username,
        photoUrl: photoUrl,
      );

      await _firebaseFirestore.collection('users').doc(_userCred.user!.uid).set(
            user.toJson(),
          );

      return _userCred;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // Login user

  Future login(String email, String password) async {
    try {
      UserCredential _userCred = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return _userCred;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
}
