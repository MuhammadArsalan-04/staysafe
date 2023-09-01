import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stay_safe_user/configurations/backend.dart';
import 'package:stay_safe_user/elements/custom_icon_button.dart';
import 'package:stay_safe_user/elements/loader.dart';
import 'package:stay_safe_user/helper/navigation_helper.dart';
import 'package:stay_safe_user/infrastructure/models/chat_arguments_model.dart';
import 'package:stay_safe_user/infrastructure/services/chat_services.dart';
import 'package:stay_safe_user/presentation/safety_app_view/chat_screen/chat_view.dart';
import 'package:stay_safe_user/presentation/safety_app_view/person_tracking/person_tracking_view.dart';

import '../../../../configurations/color_constants.dart';
import '../../../../configurations/res.dart';
import '../../../../elements/custom_button.dart';
import '../../../../elements/custom_text.dart';
import '../../../../elements/sizes.dart';
import '../../../../infrastructure/providers/friends_provider.dart';

class TrustedMembersViewBody extends StatefulWidget {
  const TrustedMembersViewBody({super.key});

  @override
  State<TrustedMembersViewBody> createState() => _TrustedMembersViewBodyState();
}

class _TrustedMembersViewBodyState extends State<TrustedMembersViewBody> {
  var isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero).then((value) async {
      //getting my friends from provider
      await Provider.of<FriendsProvider>(context, listen: false)
          .getFriends(Backend.uid)
          .then((value) => setState(() {
                isLoading = false;
              }));
    });
  }

  @override
  Widget build(BuildContext context) {
    final trustedMembers = Provider.of<FriendsProvider>(context).friendsDetails;
    return isLoading
        ? const Loader()
        : ListView.builder(
            itemCount: trustedMembers.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage(trustedMembers[index].imageUrl),
                        radius: 34,
                      ),
                      kw10,
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: 110,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: trustedMembers[index].fullname!,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            k5,
                            CustomText(
                              text: trustedMembers[index].username!,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Container(
                        child: Row(
                          children: [
                            CustomIconButton(
                              color: ColorConstants.kPrimaryColor,
                              icon: Icons.chat_rounded,
                              size: 26,
                              onPressed: () async {
                                String? chatListId = await ChatServices()
                                    .checkIfChecklistExist(Backend.uid,
                                        trustedMembers[index].userId!);

                                ChatArgumentsModel arguments =
                                    ChatArgumentsModel(
                                        userModel: trustedMembers[index],
                                        chatListId: chatListId);

                                // ignore: use_build_context_synchronously
                                NavigationHelper.pushRoute(
                                  context,
                                  ChatView.routeName,
                                  arguments,
                                );
                              },
                            ),
                            CustomIconButton(
                              color: ColorConstants.kPrimaryColor,
                              icon: Icons.near_me_rounded,
                              size: 26,
                              onPressed: () {
                                NavigationHelper.pushRoute(
                                    context,
                                    PersonTrackingView.routeName,
                                    trustedMembers[index].userId!);
                              },
                            ),
                            CustomIconButton(
                              color: ColorConstants.kPrimaryColor,
                              icon: Icons.person_remove_rounded,
                              size: 26,
                              onPressed: () async {
                                await Provider.of<FriendsProvider>(context, listen: false).removeFriend( trustedMembers[index].userId!);
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
  }
}
