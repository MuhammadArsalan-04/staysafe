import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthInstance {
  static final FirebaseAuth _firebaseInstance = FirebaseAuth.instance;

  FirebaseAuthInstance._privateConstructor();

  ///Getter Of Firebase Authentication instance
  static FirebaseAuth get firebaseAuthInstance => _firebaseInstance;
}
