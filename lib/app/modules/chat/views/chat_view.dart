import 'package:conveyance_apps/app/data/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "to: ${Get.arguments['name'].toString().capitalize}",
            style: titleText.copyWith(fontSize: 18),
          ),
          backgroundColor: secondaryColor,
          foregroundColor: whiteColor,
        ),
        body: Column(
          children: [
            buildMessageList(),
            messageInput(),
          ],
        ));
  }

  Widget buildMessageList() {
    return StreamBuilder(
      stream: controller.getMessage(
          Get.arguments['uid'], controller.authService.auth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }
        return Expanded(
          child: ListView(
            children: snapshot.data!.docs.map((e) {
              final data = e.data() as Map<String, dynamic>;
              var alignment = (data['senderId'] ==
                      controller.authService.auth.currentUser!.uid)
                  ? Alignment.centerRight
                  : Alignment.centerLeft;
              return Container(
                alignment: alignment,
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: (data['senderId'] ==
                          controller.authService.auth.currentUser!.uid)
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Text(data['senderName'].toString().toUpperCase()),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 250),
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(top: 5),
                      decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        data['message'],
                        style: bodyText.copyWith(color: whiteColor),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Widget messageInput() {
    return Container(
      height: 85,
      color: blackColor,
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(10),
              child: TextField(
                style: TextStyle(color: whiteColor),
                controller: controller.messageCtrl,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: secondaryColor,
                  hintText: "Type message...",
                  hintStyle: TextStyle(color: whiteColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  contentPadding: const EdgeInsets.all(15),
                ),
              ),
            ),
          ),
          CircleAvatar(
            radius: 30,
            backgroundColor: greenColor,
            child: IconButton(
                onPressed: () => controller.sendMessage(Get.arguments['uid']),
                icon: Icon(
                  Icons.send,
                  color: whiteColor,
                )),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
}
