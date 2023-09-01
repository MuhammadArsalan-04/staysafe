import 'package:stay_safe_user/infrastructure/models/chatlist_model.dart';
import 'package:stay_safe_user/infrastructure/models/user_model.dart';

class ChatArgumentsModel{
  UserModel userModel;
  String? chatListId;
  ChatArgumentsModel({required this.userModel,  this.chatListId});
}