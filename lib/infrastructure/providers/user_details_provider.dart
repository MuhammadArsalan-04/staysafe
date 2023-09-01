import 'package:flutter/material.dart';
import 'package:stay_safe_user/infrastructure/models/friends_model.dart';
import 'package:stay_safe_user/infrastructure/models/user_model.dart';
import 'package:stay_safe_user/infrastructure/services/friends_request_services.dart';
import 'package:stay_safe_user/infrastructure/services/user_services.dart';

import '../../configurations/backend.dart';
import '../models/friends_request_model.dart';

class UserDetailsProvider with ChangeNotifier {
  UserModel _userDetails = UserModel();
  List<UserModel> _allUsers = [];

  UserModel get getUserDetails => _userDetails;

  List<UserModel> get getAllUsers => _allUsers;

  Future<void> getAndFetchUserDetails() async {
    _userDetails = await UserServices().getUserDetails();
    notifyListeners();
  }

  Future<void> updateAndFetchUserDetails(UserModel updatedModel) async {
    try {
      await UserServices().updateUserDetails(updatedModel);
      _userDetails = updatedModel;
      notifyListeners();
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  Future<void> getAndFetchAllUsers(String id) async {
    try {
      List<UserModel> users = await UserServices().getAllUsers(id);

      final sentRequestslist =
          await FriendRequestServices().getSendRequests(id);

      final requestRecievedList = await FriendRequestServices().getRequests(id);

      //fetching added friends and removing them from the list 
      final myFriends = await FriendRequestServices().getMyFriends(id);

      //removing users from list to whom requests are already sent
      for (FriendRequestModel user in sentRequestslist) {
        users
            .removeWhere((element) => element.userId == user.requestRecieverId);
      }

      //removing users from list from whom requests are already recieved
      for (FriendRequestModel user in requestRecievedList) {
        users.removeWhere((element) => element.userId == user.requesterId);
      }

      //removing users from list who are already added as friends
      for (FriendModel user in myFriends) {
        users.removeWhere((element) => element.userId == user.friendId);
      }

      


      _allUsers = users;

      notifyListeners();
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  //remove suggested friend from list
  void removeSuggestedFriend(String friendId) {
    _allUsers.removeWhere((element) => element.userId == friendId);
    notifyListeners();
  }

  //clear all users
  void clearAllUsers() {
    _allUsers.clear();
  }

  //logout
  Future<void> logout(BuildContext context) async {
    try {
      await UserServices().logoutUser(context);
      clearAllUsers();
    } catch (err) {
      debugPrint(err.toString());
    }
  }
}
