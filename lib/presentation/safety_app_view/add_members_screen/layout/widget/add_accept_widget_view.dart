import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stay_safe_user/configurations/color_constants.dart';
import 'package:stay_safe_user/configurations/res.dart';
import 'package:stay_safe_user/elements/custom_button.dart';
import 'package:stay_safe_user/elements/custom_icon_button.dart';
import 'package:stay_safe_user/elements/custom_search.dart';
import 'package:stay_safe_user/elements/sizes.dart';
import 'package:stay_safe_user/infrastructure/models/user_model.dart';
import 'package:stay_safe_user/infrastructure/providers/user_details_provider.dart';

import '../../../../../elements/custom_text.dart';
import '../../../../../elements/snackbar_message.dart';

class AddAcceptWidgetView extends StatefulWidget {
  AddAcceptWidgetView(
      {required this.buttonText,
      required this.userModel,
      required this.index,
      required this.onTapped,
      required this.onIconTapped,
      this.tapText,
      this.showSearch = false,
      super.key});
  String buttonText;
  final bool showSearch;
  final int index;
  UserModel userModel;
  Function? onTapped;
  Function(String) onIconTapped;
  String? tapText;

  @override
  State<AddAcceptWidgetView> createState() => _AddAcceptWidgetViewState();
}

class _AddAcceptWidgetViewState extends State<AddAcceptWidgetView> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // k15,
        if (widget.index == 0 && widget.showSearch)
          CustomSearch(
            isTextFieldEnabled: true,
            controller: searchController,
            hintText: 'Search...',
            suffixIcon: Icons.search,
            suffixIconColor: ColorConstants.kPrimaryColor,
            suffixIconSize: 28,
          ),
        Card(
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.userModel.imageUrl),
                  radius: 33,
                ),
                kw10,
                Container(
                  width: 110,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: widget.userModel.fullname!,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      CustomText(
                        text: widget.userModel.username!,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                  height: 34,
                  width: 80,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    // color: ColorConstants.kPrimaryColor.withOpacity(0.9),
                  ),
                  child: CustomButton(
                    buttonText: widget.buttonText,
                    radius: 18,
                    height: 46,
                    width: 100,
                    onTapped: () {
                      
                      if (widget.tapText != null) {
                        
                        
                        setState(() {
                          widget.buttonText != widget.tapText
                              ? widget.buttonText = widget.tapText!
                              : widget.buttonText = 'Add';
                        });
                      }

                      widget.onTapped!();
                    },
                    bgColor:
                        widget.tapText == null || widget.buttonText == 'Add'
                            ? ColorConstants.kPrimaryColor.withOpacity(0.9)
                            : Colors.grey.withOpacity(0.5),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    widget.onIconTapped(widget.userModel.userId!);
                  },
                  icon: const Icon(
                    Icons.close_rounded,
                    color: Colors.grey,
                  ),
                  iconSize: 24,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
