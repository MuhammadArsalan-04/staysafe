import 'package:stay_safe_user/singleton/firebase_instance.dart';

import '../singleton/firebase_auth_instance.dart';

class Backend {
  static final kUsernames =
      FirebaseInstance.firebaseInstance.collection('usernames');
  static final kUsers = FirebaseInstance.firebaseInstance.collection('users');
  static final kFriendRequests =
      FirebaseInstance.firebaseInstance.collection('requests');
  static final kFriend =
      FirebaseInstance.firebaseInstance.collection('friends');
  static final kCustomReport =
      FirebaseInstance.firebaseInstance.collection('customReports');
  static final kChatList =
      FirebaseInstance.firebaseInstance.collection('chatlist');
  static final kChats =
      FirebaseInstance.firebaseInstance.collection('chat');
  static final kSosAlerts =
      FirebaseInstance.firebaseInstance.collection('sos_alerts');
  static final kNotifications =
      FirebaseInstance.firebaseInstance.collection('notifications');
  static final kTracking =
      FirebaseInstance.firebaseInstance.collection('tracking');
   static String uid =
      FirebaseAuthInstance.firebaseAuthInstance.currentUser!.uid;

}
