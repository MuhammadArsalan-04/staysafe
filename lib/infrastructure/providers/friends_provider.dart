import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stay_safe_user/infrastructure/models/friends_model.dart';

import '../models/user_model.dart';
import '../services/friends_request_services.dart';
import '../services/user_services.dart';

class FriendsProvider with ChangeNotifier {
  List<FriendModel> _friends = [];
  List<UserModel> _friendsDetails = [];

  List<FriendModel> get friends => _friends;

  List<UserModel> get friendsDetails => _friendsDetails;

  //get my friends
  Future<void> getFriends(String userId) async {
    try {
      clearFriendsData();
      //fetching friends
      _friends = await FriendRequestServices().getMyFriends(userId);

      //fetching each friends data
      for (var friend in _friends) {
        UserModel friendDetails =
            await UserServices().getSpecificUser(friend.friendId);
        _friendsDetails.add(friendDetails);
      }
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //clear
  void clearFriendsData() {
    _friends.clear();
    _friendsDetails.clear();
  }

  Future<void> removeFriend(String friendId)async{
    try{
      _friends.removeWhere((element) => element.friendId == friendId);
      _friendsDetails.removeWhere((element) => element.userId == friendId);
      await FriendRequestServices().unfriend(friendId);
      notifyListeners();
    }catch(e){
      debugPrint(e.toString());
    }
  }
}
