import 'package:flutter/material.dart';
import 'package:stay_safe_user/configurations/color_constants.dart';
import 'package:stay_safe_user/configurations/res.dart';
import 'package:stay_safe_user/elements/custom_text.dart';
import 'package:stay_safe_user/infrastructure/models/chat_arguments_model.dart';
import 'package:stay_safe_user/infrastructure/models/user_model.dart';
import 'package:stay_safe_user/presentation/safety_app_view/chat_screen/layout/body.dart';

import '../../../elements/sizes.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});
  static const routeName = '/chat_screen';

  @override
  Widget build(BuildContext context) {
    final model = ModalRoute.of(context)!.settings.arguments as ChatArgumentsModel;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.kPrimaryColor,
        title: Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundImage: NetworkImage(model.userModel.imageUrl),
              backgroundColor: Theme.of(context).splashColor,
            ),
            kw10,
            CustomText(text: model.userModel.fullname!),
          ],
        ),
      ),
      body:  SafeArea(child: ChatViewBody(
        model: model,
      ),),
    );
  }
}
