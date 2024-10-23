import 'package:flutter/material.dart';
import 'package:telegram/core/component/avatar.dart';
import 'package:telegram/feature/messaging/presentation/widget/reciever_details.dart';
import 'package:telegram/feature/profile/presentation/widget/user_info.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
            ],
            expandedHeight: 150.0,
            collapsedHeight: 80,
            toolbarHeight: 80,
            floating: true,
            pinned: true,
            flexibleSpace: const FlexibleSpaceBar(
              titlePadding: EdgeInsets.all(10),
              collapseMode: CollapseMode.parallax,
              centerTitle: true,
              title: RecieverDetails(
                userName: "Kiro Baghdad",
                state: "Online",
                avatar: Avatar(
                  imageUrl:
                      "https://images.rawpixel.com/image_png_social_square/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvMzY2LW1ja2luc2V5LTIxYTc3MzYtZm9uLWwtam9iNjU1LnBuZw.png",
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return const UserInfo(userNumber: "012345678");
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}
