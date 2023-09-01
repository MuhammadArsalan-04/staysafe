import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stay_safe_user/configurations/backend.dart';
import 'package:stay_safe_user/configurations/color_constants.dart';
import 'package:stay_safe_user/configurations/res.dart';
import 'package:stay_safe_user/elements/custom_text.dart';
import 'package:stay_safe_user/helper/navigation_helper.dart';
import 'package:stay_safe_user/infrastructure/services/chat_services.dart';
import 'package:stay_safe_user/presentation/safety_app_view/chat_screen/chat_view.dart';

import '../../../../elements/loader.dart';
import '../../../../elements/sizes.dart';
import '../../../../infrastructure/models/chat_arguments_model.dart';
import '../../../../infrastructure/models/user_model.dart';

class ChatListViewBody extends StatelessWidget {
  const ChatListViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: StreamBuilder(
                stream: ChatServices().getAndFetchChatListsStream(Backend.uid),
                builder: (context, snapshot) {
                  return snapshot.connectionState == ConnectionState.waiting
                      ? const Center(
                          child: Loader(),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) =>
                                StreamProvider.value(
                              initialData: UserModel(),
                              value: ChatServices().getAndFetchSpecificUser(
                                  snapshot.data![index].recieverid!),
                              builder: (context, child) {
                                UserModel userModel =
                                    Provider.of<UserModel>(context);
                                return userModel.username == null
                                    ? Column(
                                        children: [
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.3,
                                          ),
                                          const Center(
                                            child: Loader(),
                                          ),
                                        ],
                                      )
                                    : InkWell(
                                        onTap: () {
                                          //creating chatArgument Object
                                          ChatArgumentsModel
                                              chatArgumentsModel =
                                              ChatArgumentsModel(
                                                  userModel: userModel , chatListId: snapshot.data![index].chatListId);

                                          //navigating to chat screen
                                          NavigationHelper.pushRoute(
                                              context, ChatView.routeName, chatArgumentsModel);
                                        },
                                        splashColor: ColorConstants.kgreyColor
                                            .withOpacity(0.3),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                CircleAvatar(
                                                  radius: 26,
                                                  backgroundImage: NetworkImage(
                                                      userModel.imageUrl),
                                                  backgroundColor:
                                                      Theme.of(context)
                                                          .splashColor,
                                                ),
                                                kw10,
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    CustomText(
                                                      text: userModel.fullname!,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16,
                                                    ),
                                                    k5,
                                                    CustomText(
                                                      text: snapshot
                                                          .data![index]
                                                          .lastmessage!,
                                                      color: ColorConstants
                                                          .kgreyColor,
                                                    ),
                                                  ],
                                                ),
                                                const Spacer(),
                                                CustomText(
                                                  text: DateFormat('hh:mm a')
                                                      .format(snapshot
                                                          .data![index]
                                                          .lastMessageTime!
                                                          .toDate()),
                                                  color:
                                                      ColorConstants.kgreyColor,
                                                ),
                                              ],
                                            ),
                                            k5,
                                            const Divider(
                                              thickness: 1.1,
                                            ),
                                          ],
                                        ),
                                      );
                              },
                            ),
                          ),
                        );
                }),
          ),
        )
      ],
    );
  }
}
