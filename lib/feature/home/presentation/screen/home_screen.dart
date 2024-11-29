import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:telegram/core/component/capp_bar.dart';
import 'package:telegram/core/component/csnack_bar.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/utililes/app_assets/assets_strings.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/home/presentation/controller/home/home_cubit.dart';
import 'package:telegram/feature/home/presentation/controller/home/home_state.dart';
import 'package:telegram/feature/home/presentation/widget/add_stroy.dart';
import 'package:telegram/feature/home/presentation/widget/app_drawer.dart';
import 'package:telegram/feature/home/presentation/widget/chat_tile.dart';
import 'package:telegram/feature/home/presentation/widget/story.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
// Create a GlobalKey to access ScaffoldState
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      if (state.state == CubitState.loading) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Stories Section
              Container(
                color: AppColors.primaryColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: SizedBox(
                    height: 115, // Adjust height for the story section
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        AddStoryWidget(),
                        // Placeholder for story items
                        for (var story in state.stories)
                          Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: StoryWidget(
                              userName: story.userName,
                              storyUrl: story.mediaUrl,
                              isSeen: story.isSeen,
                              userImage: story.userImage,
                              storyCaption: story.content,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              // Chat Section

              // Placeholder for chat items
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),

                itemCount: state.chats.length, // Number of chats
                itemBuilder: (context, index) {
                  final chat = state.chats[index];
                  return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: ChatTileWidget(
                        id: chat.id,
                        imageUrl: chat.imageUrl,
                        title: chat.name,
                        subtitle: chat.lastMessage,
                        onTap: () {
                          // Chat tap logic
                        },
                        time: chat.time,
                        messageStatus: chat.messageStatus, // Add message status
                      ));
                },
              ),
            ],
          ),
        );
      } else if (state.state == CubitState.failure) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CSnackBar.showErrorSnackBar(context, 'Error', 'Failed to load data');
        });
      }
      return Scaffold(
        key: _scaffoldKey, // Assign the GlobalKey here

        drawer: const CAppDrawer(),
        appBar: CAppBar(
          leadingIcon: Icons.menu,
          title: Text('Mazrof'),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.search,
                size: 30,
              ),
            ),
          ],
          onLeadingTap: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        body: HomeContent(
          state: state,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primaryColor,
          onPressed: () {
            // Add story logic
          },
          child: Icon(Icons.camera_alt, color: AppColors.whiteColor, size: 30),
        ),
      );
    });
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({
    required this.state,
    super.key,
  });
  final state;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stories Section
          Container(
            color: AppColors.primaryColor,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: SizedBox(
                height: 115, // Adjust height for the story section
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    AddStoryWidget(),
                    // Placeholder for story items
                    for (var story in state.stories)
                      StoryWidget(
                        userName: story.userName,
                        storyUrl: story.mediaUrl,
                        isSeen: story.isSeen,
                        userImage: story.userImage,
                        storyCaption: story.content,
                      ),
                  ],
                ),
              ),
            ),
          ),
          // Chat Section

          // Placeholder for chat items
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),

            itemCount: state.chats.length, // Number of chats
            itemBuilder: (context, index) {
              final chat = state.chats[index];
              return ChatTileWidget(
                id: chat.id,
                imageUrl: chat.imageUrl,
                title: chat.name,
                subtitle: chat.lastMessage,
                onTap: () {
                  sl<HomeCubit>().loadHomeData();
                  // Chat tap logic
                },
                time: chat.time,
                messageStatus: chat.messageStatus, // Add message status
              );
            },
          ),
        ],
      ),
    );
  }
}
