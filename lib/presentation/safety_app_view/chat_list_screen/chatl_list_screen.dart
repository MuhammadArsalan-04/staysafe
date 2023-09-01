import 'package:flutter/material.dart';
import 'package:stay_safe_user/configurations/color_constants.dart';
import 'package:stay_safe_user/presentation/safety_app_view/chat_list_screen/layout/body.dart';
import '../../../elements/custom_text.dart';

class ChatListView extends StatelessWidget {
  const ChatListView({super.key});
  static const routeName = '/chat_list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        centerTitle: true,
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0,
        title: CustomText(
          text: 'Chat',
          color: ColorConstants.kBlackColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: const SafeArea(child: ChatListViewBody()),
    );
  }
}
