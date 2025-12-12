import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sync User Data
  Future<void> syncUser(UserModel user) async {
    final currentUser = _auth.currentUser;
    if (currentUser == null) return; // Not logged in

    try {
      await _firestore.collection('users').doc(currentUser.uid).set(user.toMap());
    } catch (e) {
      print('Error syncing user: $e');
    }
  }

  // Fetch User Data
  Future<UserModel?> fetchUser() async {
    final currentUser = _auth.currentUser;
    if (currentUser == null) return null;

    try {
      final doc = await _firestore.collection('users').doc(currentUser.uid).get();
      if (doc.exists && doc.data() != null) {
        return UserModel.fromMap(doc.data()!);
      }
    } catch (e) {
      print('Error fetching user: $e');
    }
    return null;
  }
}
