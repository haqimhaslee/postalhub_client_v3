import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createUserData(User? user, Map<String, dynamic> userData) async {
    try {
      await _db.collection('client_user').doc(user?.uid).set(userData);
      // ignore: empty_catches
    } catch (e) {}
  }
}
