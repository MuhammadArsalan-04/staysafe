import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseInstance {
  static final FirebaseFirestore _firebaseInstance = FirebaseFirestore.instance;

  FirebaseInstance._privateConstructor();
  ///Getter of Firebase Firestore Instance
  static FirebaseFirestore get firebaseInstance => _firebaseInstance;
}
