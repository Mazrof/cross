import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/component/Capp_bar.dart';
import 'package:telegram/core/component/csnack_bar.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/helper/screen_helper.dart';
import 'package:telegram/core/local/hive.dart';

import 'package:telegram/core/routes/app_router.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/core/utililes/app_sizes/app_sizes.dart';
import 'package:telegram/feature/channels/create_channel/data/model/channel_model.dart';
import 'package:telegram/feature/groups/add_new_group/data/model/groups_model.dart';
import 'package:telegram/feature/groups/add_new_group/presentation/widget/shimmer_loading_list.dart';
import 'package:telegram/feature/groups/group_setting/data/model/group_setting_model.dart';

import 'package:telegram/feature/home/presentation/controller/home/home_cubit.dart';
import 'package:telegram/feature/home/presentation/controller/home/home_state.dart';
import 'package:telegram/feature/home/presentation/widget/add_stroy.dart';
import 'package:telegram/feature/home/presentation/widget/app_drawer.dart';
import 'package:telegram/feature/home/presentation/widget/channel_tile.dart';
import 'package:telegram/feature/home/presentation/widget/chat_tile.dart';
import 'package:telegram/feature/home/presentation/widget/group_tile.dart';
import 'package:telegram/feature/home/presentation/widget/story.dart';
import 'package:shimmer/shimmer.dart';
import 'package:telegram/feature/home/presentation/widget/tab_bar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // Create a GlobalKey to access ScaffoldState
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<HomeCubit>()..loadHomeData(),
      child: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
        if (state.state == CubitState.loading) {
          return _buildScaffold(
            context,
            body: ShimmerLoadingContent(),
          );
        } else if (state.state == CubitState.failure) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            CSnackBar.showErrorSnackBar(
                context, 'Error', 'Failed to load data');
          });
        }

        // Success State
        return _buildScaffold(
          context,
          body: HomeContent(state: state),
        );
      }),
    );
  }

  Widget _buildScaffold(BuildContext context, {required Widget body}) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const CAppDrawer(),
      appBar: CAppBar(
        leadingIcon: Icons.menu,
        title: const Text('Mazrof'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Icon(
              Icons.search,
              size: 30,
            ),
          ),
        ],
        onLeadingTap: () {
          _scaffoldKey.currentState?.openDrawer();
        },
      ),
      body: body,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          // Add story logic
        },
        child:
            const Icon(Icons.camera_alt, color: AppColors.whiteColor, size: 30),
      ),
    );
  }
}

class ShimmerLoadingContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: AppColors.primaryColor,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: SizedBox(
              height: ScreenHelper.getScreenHeight(context) * .11,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5, // Number of placeholder items
                itemBuilder: (context, index) => Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: const StoryWidget(
                    userName: '',
                    storyUrl: '',
                    isSeen: false,
                    userImage: '',
                    storyCaption: '',
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: ScreenHelper.getScreenHeight(context) * .5,
          child: ListView.builder(
            itemCount: 10, // Number of placeholder items
            itemBuilder: (context, index) => Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: ChatTile(
                id: 0,
                imageUrl: '',
                title: '...',
                subtitle: '...',
                time: '',
                messageStatus: MessageStatus.loading,
                onTap: () {},
                lastSeen: '',
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({required this.state, super.key});

  final HomeState state;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              bottom: TTabBar(
                tabs: [
                  Tab(text: 'Contacts'),
                  Tab(text: 'Channels'),
                  Tab(text: 'Groups'),
                ],
              ),
              automaticallyImplyLeading: false,
              pinned: true,
              floating: true,
              expandedHeight: 160.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: AppColors.primaryColor,
                ),
                expandedTitleScale: 1,
                title: SizedBox(
                  height: ScreenHelper.getScreenHeight(context) * .2,
                  child: ListView(
                    children: [
                      // Stories Section
                      Container(
                        color: AppColors.primaryColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          child: SizedBox(
                            height: ScreenHelper.getScreenHeight(context) * .13,
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
                    ],
                  ),
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          children: [
            CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final chat = state.contacts[index];
                      return ChatTile(
                        id: chat.id,
                        imageUrl: "",
                        title: chat.secondUser.username,
                        subtitle: chat.lastMessage!.content,
                        time: chat.lastMessage!.createdAt.toString(),
                        messageStatus: MessageStatus.delivered,
                        onTap: () {
                          GoRouter.of(context).push(
                            '${AppRouter.kMessaging}/$index/channel',
                          );
                        },
                        lastSeen: chat.secondUser.lastSeen.toString(),
                      );
                    },
                    childCount: state.contacts.length,
                  ),
                ),
              ],
            ),
            CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final channel = state.channels[index];
                      return ChannelTile(
                        id: channel.id,
                        imageUrl: channel.imageUrl ?? "",
                        title: channel.name,
                        subtitle: channel.lastMessage != null
                            ? channel.lastMessage!.content
                            : '',
                        time: channel.lastMessage != null
                            ? channel.lastMessage!.createdAt.toString()
                            : '',
                        onTap: () {
                          GoRouter.of(context).push(
                            AppRouter.kChannelScreen,
                            extra: ChannelModel(
                              id: channel.id,
                              name: channel.name,
                              privacy: channel.privacy,
                              canAddComments: channel.canAddComments,
                              imageUrl: channel.imageUrl ?? '',
                              invitationLink: channel.invitationLink ?? '',
                            ),
                          );
                          // GoRouter.of(context).push(
                          //   '${AppRouter.kMessaging}/$index/channel',
                          // );
                        },
                        lastSeen: '',
                      );
                    },
                    childCount: state.channels.length,
                  ),
                ),
              ],
            ),
            CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      print(state.groups[index].lastMessage);
                      final group = state.groups[index];
                      return GroupTile(
                        id: group.id,
                        imageUrl: group.imageUrl ?? "",
                        title: group.name,
                        subtitle: group.lastMessage != null
                            ? group.lastMessage!.content
                            : '',
                        time: group.lastMessage != null
                            ? group.lastMessage!.createdAt.hour.toString()
                            : '',
                        onTap: () {
                          GoRouter.of(context).push(
                            AppRouter.kGroupScreen,
                            extra: GroupModel(
                              id: group.id,
                              name: group.name,
                              privacy: group.privacy,
                              groupSize: group.groupSize!,
                              imageUrl: group.imageUrl ?? '',
                            ),
                          );
                          // GoRouter.of(context).push(
                          //   '${AppRouter.kMessaging}/$index/group',
                          // );
                        },
                        lastSeen: '',
                      );
                    },
                    childCount: state.groups.length,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
