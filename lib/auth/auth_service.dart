// ignore_for_file: avoid_returning_null_for_void

import 'package:firebase_auth/firebase_auth.dart';
import 'firestore_services.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();

  get user => null;

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

  // Sign out
  Future<void> signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }
}
