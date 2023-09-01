import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../configurations/backend.dart';

class UsernameProvider with ChangeNotifier {
  bool _usernameStatus = false;
  bool _loadingStatus = false;
  //checking username
  Future<void> checkUsername(String username) async {
    try {
      final snapshot =
          await Backend.kUsernames.where('username', isEqualTo: username).get();
      if (snapshot.docs.isEmpty) {
        _usernameStatus = false;
      } else {
        _usernameStatus = true;
        debugPrint(true.toString());
      }
    } on FirebaseException catch (ex) {
      debugPrint(ex.message);
      _usernameStatus = false;
    } catch (err) {
      debugPrint(err.toString());
      _usernameStatus = false;
    }
    notifyListeners();
  }

  bool get getUsernameStatus {
    return _usernameStatus;
  }

  set setLoadingStatus(bool status) {
    _loadingStatus = status;
    notifyListeners();
  }

  bool get getLoadingStatus {
    return _loadingStatus;
  }
}
