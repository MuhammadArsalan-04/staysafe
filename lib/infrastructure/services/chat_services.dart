import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stay_safe_user/configurations/backend.dart';
import 'package:stay_safe_user/infrastructure/models/user_model.dart';

import '../models/chatlist_model.dart';
import '../models/message_model.dart';

class ChatServices {
  //checking if ChatListExist
  Future<String?> checkIfChecklistExist(
      String senderId, String recieverId) async {
    String? id;

    try {
      id = await Backend.kChatList
          .doc(senderId)
          .collection('recent_chats')
          .doc(recieverId)
          .get()
          .then((value) => value.exists)
          .then((result) async => result
              ? await getAndFetchChatListId(senderId, recieverId)
              : null);
      debugPrint(id);
      return id;
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  Future<String> getAndFetchChatListId(
      String senderId, String recieverId) async {
    String id = await Backend.kChatList
        .doc(senderId)
        .collection('recent_chats')
        .doc(recieverId)
        .get()
        .then((value) => value.data()!['chatListId']);

    return id;
  }

  //creating chatList
  Future<String> createOrFetchChatList(
      String senderId, String recieverId, String message,
      [String? chatListId]) async {
    final id = chatListId ?? Backend.kChatList.doc().id;

    final lastMessageTime = Timestamp.now();
    await Backend.kChatList
        .doc(senderId)
        .collection('recent_chats')
        .doc(recieverId)
        .set(ChatListModel(
          chatListId: id,
          lastMessageTime: lastMessageTime,
          lastmessage: message.isEmpty ? "Say, Hello" : message,
          senderid: senderId,
          recieverid: recieverId,
        ).toJson())
        .then((_) async => await Backend.kChatList
            .doc(recieverId)
            .collection('recent_chats')
            .doc(senderId)
            .set(ChatListModel(
              chatListId: id,
              lastMessageTime: lastMessageTime,
              lastmessage: message.isEmpty ? "Say, Hello" : message,
              senderid: recieverId,
              recieverid: senderId,
            ).toJson()));

    return id;
  }


  Future<void> sendMessage(
      String chatListId,
      String senderId,
      String recieverId,
      String message,
      String messageType, [double? lat , double? long]) async {
    final messageTime = Timestamp.now();
    final messageId = Backend.kChats
        .doc(chatListId)
        .collection('messages')
        .doc()
        .id;
    Backend.kChats
        .doc(chatListId)
        .collection('messages')
        .doc(messageId)
        .set(
            MessageModel(
              message: message,
              messageType: messageType,
              messageId: messageId,
              recieverId:  recieverId,
              senderId: senderId,
              messageTime: messageTime,
              lat: lat,
              long: long,
            ).toJson(),
            SetOptions(merge: true));
  }

   Stream<List<ChatListModel>> getAndFetchChatListsStream(String userId) {
    return Backend.kChatList
        .doc(userId)
        .collection('recent_chats')
        .snapshots()
        .map((event) =>
            event.docs.map((e) => ChatListModel.fromJson(e.data())).toList());
  }

  Stream<UserModel> getAndFetchSpecificUser(String id)  {
    return Backend.kUsers
        .doc(id)
        .snapshots()
        .map((snapshot) => UserModel.fromJson(snapshot.data()!));
  }

  Stream<List<MessageModel>> getAndFetchMessages(String chatListId) {
    print(chatListId);
    return Backend.kChats
        .doc(chatListId)
        .collection('messages')
        .orderBy(
          'messageTime',
          descending: true,
        )
        .snapshots()
        .map((event) =>
            event.docs.map((e) => MessageModel.fromJson(e.data())).toList());
  }

}
