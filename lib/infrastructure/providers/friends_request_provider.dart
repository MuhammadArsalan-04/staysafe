import 'package:flutter/material.dart';
import 'package:stay_safe_user/infrastructure/models/friends_request_model.dart';
import 'package:stay_safe_user/infrastructure/models/user_model.dart';
import 'package:stay_safe_user/infrastructure/services/friends_request_services.dart';
import 'package:stay_safe_user/infrastructure/services/user_services.dart';
import 'package:stay_safe_user/singleton/firebase_instance.dart';

import '../../configurations/backend.dart';

class FriendsRequestProvider with ChangeNotifier {
  List<String> _friends = [];
  List<UserModel> _listOfFriendRequest = [];
  List<FriendRequestModel> _allFriendriendRequest = [];

  //sent friend request to firebase
  Future<void> sendFriendRequest(String userId, String friendId) async {
    try {
      await FriendRequestServices().sendingFriendRequest(userId, friendId);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //get friend request from firebase
  Future<void> getFriendRequest(String userId) async {
    try {
      _listOfFriendRequest.clear();
      _allFriendriendRequest = await FriendRequestServices().getRequests(userId);

      for (var request in _allFriendriendRequest) {
        UserModel requesterDetails =await UserServices().getSpecificUser(request.requesterId);
        _listOfFriendRequest.add(requesterDetails);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    notifyListeners();
  }


  //accept friend request
  Future<void> acceptRequest(String requestId, String requesterId) async {
    try {

      _friends.add(
          requesterId);
      
      _listOfFriendRequest.removeWhere((element) => element.userId == requesterId);
            await FriendRequestServices().acceptFriendRequest(requestId , requesterId);
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }


  //reject Friend Request
  Future<void> rejectRequest(String requestId, String requesterId) async {
    try {
      await FriendRequestServices().rejectFriendRequest(requestId);
      _listOfFriendRequest.removeWhere((element) => element.userId == requesterId);
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
 

  List<UserModel> get getListOfFriendRequest => _listOfFriendRequest;
  List<FriendRequestModel> get getAllFriendRequestsData => _allFriendriendRequest;

  // List<String> get friends => _friends;

  // void addFriend(String friendId){
  //   _friends.add(friendId);
  //   notifyListeners();
  // }

  // void removeFriend(String friendId){
  //   _friends.remove(friendId);
  //   notifyListeners();
  // }

  // bool isFriend(String friendId){
  //   return _friends.contains(friendId);
  // }
}
