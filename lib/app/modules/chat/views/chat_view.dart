import 'package:cached_network_image/cached_network_image.dart';
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
          titleSpacing: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: Get.arguments['profile_photo'] ??
                    "https://images.unsplash.com/photo-1511367461989-f85a21fda167?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D",
                imageBuilder: (context, imageProvider) => Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Get.arguments['name'].toString().capitalize.toString(),
                    style: titleText.copyWith(fontSize: 18),
                  ),
                  Text(
                    Get.arguments['email'].toString(),
                    style: subtitleText.copyWith(
                        color: whiteColor, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ],
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
      decoration: BoxDecoration(
        color: blackColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
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
