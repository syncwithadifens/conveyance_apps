import 'package:cached_network_image/cached_network_image.dart';
import 'package:conveyance_apps/app/data/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: secondaryColor,
        appBar: AppBar(
          title: const Text('People'),
          actions: [
            IconButton(
                onPressed: () => controller
                    .logOut()
                    .then((value) => Get.offNamed(Routes.LOGIN)),
                icon: const Icon(Icons.exit_to_app))
          ],
          backgroundColor: blackColor,
          foregroundColor: whiteColor,
        ),
        body: _buildListUser());
  }

  Widget _buildListUser() {
    return StreamBuilder(
      stream:
          controller.firebaseServiceProvider.db.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }
        return ListView(
          children: snapshot.data != null
              ? snapshot.data!.docs.map((e) {
                  final data = e.data();
                  if (controller
                          .firebaseServiceProvider.auth.currentUser!.email !=
                      data['email']) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Map<String, dynamic> userData = {
                              'uid': data['uid'],
                              'name': data['name'],
                              'email': data['email'],
                              'profile_photo': data['profile_photo'],
                            };
                            Get.toNamed(Routes.CHAT, arguments: userData);
                          },
                          child: ListTile(
                            textColor: whiteColor,
                            leading: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: data['profile_photo'] ??
                                  "https://images.unsplash.com/photo-1511367461989-f85a21fda167?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D",
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      CircularProgressIndicator(
                                          value: downloadProgress.progress),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                            title: Text(data['email']),
                            subtitle: Text(data['name']),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                }).toList()
              : [
                  Padding(
                    padding: const EdgeInsets.only(top: 200),
                    child: Center(
                      child: Text(
                        "Belum ada user lain",
                        style: titleText.copyWith(color: whiteColor),
                      ),
                    ),
                  ),
                ],
        );
      },
    );
  }
}
