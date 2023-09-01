import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stay_safe_user/configurations/backend.dart';
import 'package:stay_safe_user/configurations/color_constants.dart';
import 'package:stay_safe_user/infrastructure/models/chat_arguments_model.dart';
import 'package:stay_safe_user/infrastructure/models/message_model.dart';
import 'package:stay_safe_user/infrastructure/models/user_model.dart';

import '../../../../configurations/res.dart';
import '../../../../elements/custom_textfield.dart';
import '../../../../elements/loader.dart';
import '../../../../elements/message_tile.dart';
import '../../../../elements/sizes.dart';
import '../../../../infrastructure/services/chat_services.dart';
import 'widget/send_recieve_msg.dart';

import 'package:path_provider/path_provider.dart' as sysPath;
import 'package:path/path.dart' as path;

class ChatViewBody extends StatefulWidget {
  final ChatArgumentsModel? model;
  const ChatViewBody({super.key, this.model});

  @override
  State<ChatViewBody> createState() => _ChatViewBodyState();
}

class _ChatViewBodyState extends State<ChatViewBody> {
  bool showSendIcon = false;
  TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: widget.model!.chatListId == null
              ? SizedBox()
              : StreamProvider.value(
                  initialData: [MessageModel()],
                  value: ChatServices()
                      .getAndFetchMessages(widget.model!.chatListId!),
                  builder: (context, child) {
                    List<MessageModel> _messages =
                        context.watch<List<MessageModel>>();
                    return _messages[0].messageId == null
                        ? const Center(
                            child: Loader(),
                          )
                        : ListView.builder(
                            reverse: true,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            itemCount: _messages.length,
                            itemBuilder: (context, index) {
                              bool isSentByMe =
                                  _messages[index].senderId == Backend.uid;
                              return MessageTile(
                                  chatListId: widget.model!.chatListId!,
                                  messageId: _messages[index].messageId!,
                                  message: _messages[index].message!,
                                  sendByMe: isSentByMe,
                                  senderId:_messages[index].senderId!,
                                  time: DateFormat('hh:mm a').format(
                                    (_messages[index].messageTime!.toDate()),
                                  ),
                                  type: _messages[index].messageType!);
                            },
                          );
                  },
                  
                ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Focus(
                  onFocusChange: (value) {
                    setState(() {
                      showSendIcon = value;
                    });
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            controller: messageController,
                            hintText: 'Send a message',
                          ),
                        ),
                        if (!showSendIcon)
                          IconButton(
                            onPressed: () async {
                              pickImage();
                            },
                            icon: const Icon(
                              Icons.image,
                              color: ColorConstants.kgreyColor,
                              size: 34,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              kw10,
              showSendIcon
                  ? ElevatedButton(
                      onPressed: () {
                        if (messageController.text.isEmpty) {
                          return;
                        }

                        String message = messageController.text.trim();
                        //creating or updating chat list
                        ChatServices()
                            .createOrFetchChatList(
                          Backend.uid,
                          widget.model!.userModel.userId!,
                          message,
                          widget.model!.chatListId,
                        )
                            .then((chatId) async {
                          widget.model!.chatListId = chatId;

                          //sending message
                          ChatServices().sendMessage(chatId, Backend.uid,
                              widget.model!.userModel.userId!, message, "text");
                        });

                        messageController.clear();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstants.kPrimaryColor,
                          minimumSize: const Size(58, 58),
                          alignment: Alignment.center,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          )),
                      child: const Center(
                        child: Icon(
                          Icons.send_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        )
      ],
    );
  }

  void getCapturedImage(File capturedFile) async {
    //uploading to firebase
    final ref = FirebaseStorage.instance.ref(capturedFile.path);
    await ref.putFile(capturedFile);
    String imageUrl = await ref.getDownloadURL();

    //uploading recent chat
    ChatServices()
        .createOrFetchChatList(Backend.uid, widget.model!.userModel.userId!,
            'photo', widget.model!.chatListId)
        .then((id) async {
      ChatServices().sendMessage(
          id, Backend.uid, widget.model!.userModel.userId!, imageUrl, "image");
    });
  }

  Future<void> pickImage() async {
    XFile? captureImage;
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 120,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () async {
                      captureImage = await ImagePicker()
                          .pickImage(source: ImageSource.camera);

                      getCapturedImage(File(captureImage!.path));
                    },
                    icon: const Icon(
                      Icons.camera_alt_rounded,
                      size: 50,
                    )),
                IconButton(
                  onPressed: () async {
                    captureImage = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);

                    setPath(File(captureImage!.path));
                  },
                  icon: const Icon(
                    Icons.collections,
                    size: 50,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void setPath(File image) async {
    if (image.path.isEmpty) {
      return;
    }
    Directory appDirectory = await sysPath.getApplicationDocumentsDirectory();
    String fileName = path.basename(image.path);

    final File pickedImage = await image.copy("${appDirectory.path}/$fileName");

    getCapturedImage(pickedImage);
  }
}
