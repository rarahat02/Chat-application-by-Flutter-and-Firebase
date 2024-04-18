import 'package:chat_app_firebase_riverpod/features/auth/data/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthService(this._firebaseAuth, this._firestore);

  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();

  Future<UserCredential> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    try {
      // signin
      UserCredential userCredentials = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      return userCredentials;
    } on FirebaseAuthException catch (e) {
      // catch errors related to firebase login
      throw Exception(e.code);
    }
  }

  Future<UserCredential> signupWithEmailPassword(
      String name, String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      final user = UserModel(
          uid: userCredential.user?.uid,
          firstName: name,
          email: userCredential.user?.email);

      await _firestore
          .collection('USER')
          .doc(userCredential.user?.uid)
          .set(user.toMap());

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // sign out method
  Future<void> signOutUser() async {
    await _firebaseAuth.signOut();
  }
}

final authServiceProvider = Provider.autoDispose<AuthService>(
    (ref) => AuthService(FirebaseAuth.instance, FirebaseFirestore.instance));

final authStateProvider = StreamProvider<User?>(
    (ref) => ref.read(authServiceProvider).authStateChange);
