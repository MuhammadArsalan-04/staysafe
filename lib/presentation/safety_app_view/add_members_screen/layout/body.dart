import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stay_safe_user/configurations/backend.dart';
import 'package:stay_safe_user/elements/loader.dart';
import 'package:stay_safe_user/elements/snackbar_message.dart';
import 'package:stay_safe_user/infrastructure/models/user_model.dart';
import 'package:stay_safe_user/infrastructure/providers/friends_request_provider.dart';
import 'package:stay_safe_user/infrastructure/providers/user_details_provider.dart';
import 'package:stay_safe_user/presentation/safety_app_view/add_members_screen/layout/widget/add_accept_widget_view.dart';
import 'package:stay_safe_user/presentation/safety_app_view/add_members_screen/layout/widget/custom_add_member_tabbar.dart';

import '../../../../configurations/color_constants.dart';
import '../../../../elements/custom_search.dart';

class AddMembersViewBody extends StatefulWidget {
  const AddMembersViewBody({super.key});

  @override
  State<AddMembersViewBody> createState() => _AddMembersViewBodyState();
}

class _AddMembersViewBodyState extends State<AddMembersViewBody> {
  bool isLoading = true;
  TextEditingController searchController = TextEditingController();

  List<UserModel> searchResult = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero).then((value) async {
      //getting user details
      await Provider.of<UserDetailsProvider>(context, listen: false)
          .getAndFetchAllUsers(Backend.uid);

      //getting friend request
      // ignore: use_build_context_synchronously
      await Provider.of<FriendsRequestProvider>(context, listen: false)
          .getFriendRequest(Backend.uid);
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final allUsers = searchController.text.isEmpty
        ? Provider.of<UserDetailsProvider>(context).getAllUsers
        : searchResult;
    final allRequests =
        Provider.of<FriendsRequestProvider>(context).getListOfFriendRequest;
    return isLoading
        ? const Loader()
        : DefaultTabController(
            length: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CustomAddMemberTabBar(),
                  Expanded(
                    child: TabBarView(children: [
                      ListView.builder(
                        itemCount: allUsers.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              if (index == 0)
                                Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 10, top: 15),
                                  child: TextFormField(
                                    onChanged: (value) {
                                      setState(() {
                                        searchResult = allUsers
                                            .where((element) => element
                                                .username!
                                                .toLowerCase()
                                                .contains(value.toLowerCase()))
                                            .toList();
                                      });
                                    },
                                    controller: searchController,
                                    cursorColor: ColorConstants.kPrimaryColor,
                                    textAlign: TextAlign.left,
                                    textAlignVertical: TextAlignVertical.center,
                                    decoration: InputDecoration(
                                      fillColor: ColorConstants.kgreyColor,
                                      filled: false,
                                      enabled: true,
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: ColorConstants.kgreyColor),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: ColorConstants.kgreyColor),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: ColorConstants.kgreyColor),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: ColorConstants.kgreyColor),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      hintText: "Search...",
                                      contentPadding: const EdgeInsets.only(
                                        left: 30,
                                        top: 22,
                                        right: 30,
                                        bottom: 22,
                                      ),
                                      hintStyle: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              // CustomSearch(
                              //   isTextFieldEnabled: true,
                              //   controller: searchController,
                              //   hintText: 'Search...',

                              //   suffixIcon: Icons.search,
                              //   suffixIconColor: ColorConstants.kPrimaryColor,
                              //   suffixIconSize: 28,
                              // ),
                              AddAcceptWidgetView(
                                userModel: allUsers[index],
                                onTapped: () async {
                                  
                                  await Provider.of<FriendsRequestProvider>(
                                          context,
                                          listen: false)
                                      .sendFriendRequest(
                                          Backend.uid, allUsers[index].userId!);
                                },
                                buttonText: 'Add',
                                index: index,
                                tapText: "sent",
                                onIconTapped: (id) {
                                  removeSuggestedUser(id);
                                },
                                showSearch: false,
                              )
                            ],
                          );
                        },
                      ),
                      ListView.builder(
                        itemCount: allRequests.length,
                        itemBuilder: (context, index) {
                          return AddAcceptWidgetView(
                            onTapped: () async {
                              final allRequestsData =
                                  Provider.of<FriendsRequestProvider>(context,
                                          listen: false)
                                      .getAllFriendRequestsData;
                              Provider.of<FriendsRequestProvider>(context,
                                      listen: false)
                                  .acceptRequest(allRequestsData[index].id!,
                                      allRequestsData[index].requesterId);
                            },
                            onIconTapped: (id) {
                              final ref = Provider.of<FriendsRequestProvider>(
                                  context,
                                  listen: false);

                              final allRequestsData =
                                  ref.getAllFriendRequestsData;

                              ref.rejectRequest(allRequestsData[index].id!,
                                  allRequestsData[index].requesterId);
                            },
                            userModel: allRequests[index],
                            buttonText: 'Accept',
                            index: index,
                            showSearch: false,
                          );
                        },
                      ),
                    ]),
                  )
                ],
              ),
            ));
  }

  //removing suggested user
  void removeSuggestedUser(String friendId) {
    Provider.of<UserDetailsProvider>(context, listen: false)
        .removeSuggestedFriend(friendId);
  }

  //rejecting friend request
  Future<void> rejectFriendRequest(String requestId, requesterId) async {
    await Provider.of<FriendsRequestProvider>(context, listen: false)
        .rejectRequest(requestId, requesterId);
  }
}
