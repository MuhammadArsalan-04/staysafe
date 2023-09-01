import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stay_safe_user/configurations/backend.dart';
import 'package:stay_safe_user/infrastructure/models/friends_model.dart';

import '../models/friends_request_model.dart';

class FriendRequestServices {
  //Send Friend Request
  Future<void> sendingFriendRequest(String userId, String friendId) async {
    final requestId = Backend.kFriendRequests.doc().id;
    await Backend.kFriendRequests.doc(requestId).set(FriendRequestModel(
            id: requestId, requesterId: userId, requestRecieverId: friendId)
        .toJson());
  }

  //Get Friend Request
  Future<List<FriendRequestModel>> getRequests(String userId) async {
    final requests = await Backend.kFriendRequests
        .where('RequestRecieverId', isEqualTo: userId)
        .where("isAccepted", isEqualTo: false)
        .where("isRejected", isEqualTo: false)
        .get();
    return requests.docs
        .map((e) => FriendRequestModel.fromJson(e.data()))
        .toList();
  }

//get send request
  Future<List<FriendRequestModel>> getSendRequests(String userId) async {
    final requests = await Backend.kFriendRequests
        .where('RequesterId', isEqualTo: userId)
        .get();
    return requests.docs
        .map((e) => FriendRequestModel.fromJson(e.data()))
        .toList();
  }

  //Accept Friend Request
  Future<void> acceptFriendRequest(String requestId, String requesterId) async {
    await Backend.kFriendRequests.doc(requestId).update({
      'isAccepted': true,
    });
    final friendRef = Backend.kFriend.doc();
    final friendId = friendRef.id;
    await Backend.kFriend
        .doc(Backend.uid)
        .collection("my_friends")
        .doc(requesterId)
        .set(FriendModel(id: friendId, friendId: requesterId).toJson());

    await Backend.kFriend
        .doc(requesterId)
        .collection("my_friends")
        .doc(Backend.uid)
        .set(FriendModel(id: friendId, friendId: Backend.uid).toJson());
  }

  //get my friends
  Future<List<FriendModel>> getMyFriends(String userId) async {
    final friends =
        await Backend.kFriend.doc(userId).collection("my_friends").get();
    return friends.docs.map((e) => FriendModel.fromJson(e.data())).toList();
  }
//get All Friend id
  Future<List<String>> getAllFriendId(String userId) async {
    final friends =
        await Backend.kFriend.doc(userId).collection("my_friends").get();
    return friends.docs.map((e) => e.data()['friendId'] as String).toList();
  }
  //Reject Friend Request
  Future<void> rejectFriendRequest(String requestId) async {
    await Backend.kFriendRequests.doc(requestId).delete();
  }

  //remove a friend
  Future<void> unfriend(String friendId) async {
    await Backend.kFriend
        .doc(Backend.uid)
        .collection("my_friends")
        .doc(friendId)
        .delete();
    await Backend.kFriend
        .doc(friendId)
        .collection("my_friends")
        .doc(Backend.uid)
        .delete();
  }
}
