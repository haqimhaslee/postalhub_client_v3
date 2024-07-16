// ignore_for_file: avoid_returning_null_for_void

import 'package:firebase_auth/firebase_auth.dart';
import 'firestore_services.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();

  get user => null;

  // Sign in with email and password
  static Future<void> login(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw 'No user found for that email.';
        case 'wrong-password':
          throw 'Wrong password provided.';
        default:
          throw 'Login failed. Please try again.';
      }
    }
  }

  // Register with email and password and additional user data
  Future<User?> registerWithEmailAndPassword(
      String email, String password, Map<String, dynamic> userData) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      await _firestoreService.createUserData(user, userData);
      return user;
    } catch (e) {
      return null;
    }
  }

  // Sign out V2
  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  // Sign out
  Future<void> signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }
}
