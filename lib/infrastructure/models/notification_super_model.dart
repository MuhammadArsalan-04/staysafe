// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:stay_safe_user/infrastructure/models/notification_model.dart';
import 'package:stay_safe_user/infrastructure/models/user_model.dart';

class NotificationSuperModel {
  List<NotificationsModel> allNotificaitons ;
  List<UserModel> listOfUsers ;
  NotificationSuperModel({
     this.allNotificaitons = const [],
     this.listOfUsers = const [],
  });



}
