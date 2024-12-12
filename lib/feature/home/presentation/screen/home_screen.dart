import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram/core/component/Capp_bar.dart';
import 'package:telegram/core/component/csnack_bar.dart';
import 'package:telegram/core/helper/screen_helper.dart';
import 'package:telegram/core/local/hive.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/core/utililes/app_sizes/app_sizes.dart';
import 'package:telegram/feature/groups/add_new_group/presentation/widget/shimmer_loading_list.dart';
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
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      if (state.state == CubitState.loading) {
        return _buildScaffold(
          context,
          body: ShimmerLoadingContent(),
        );
      } else if (state.state == CubitState.failure) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CSnackBar.showErrorSnackBar(context, 'Error', 'Failed to load data');
        });
      }

      // Success State
      return _buildScaffold(
        context,
        body: HomeContent(state: state),
      );
    });
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
                    userName: 'Loading...',
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
                  Tab(text: 'Groups'),
                  Tab(text: 'Channels'),
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
                  height: ScreenHelper.getScreenHeight(context) * .3,
                  child: ListView(
                    children: [
                      // Stories Section
                      Container(
                        color: AppColors.primaryColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          child: SizedBox(
                            height: ScreenHelper.getScreenHeight(context) * .3,
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
                        id: int.parse(chat.chatId),
                        imageUrl: "",
                        title: chat.participants.first.userId ==
                                HiveCash.read(
                                    boxName: "register_info", key: "id")
                            ? chat.participants.last.name
                            : chat.participants.first.name,
                        subtitle: chat.lastMessage.content,
                        time: chat.lastMessage.timestamp,
                        messageStatus: MessageStatus.delivered,
                        onTap: () {
                          // Open chat screen
                        },
                        lastSeen: chat.participants.first.userId ==
                                HiveCash.read(
                                    boxName: "register_info", key: "id")
                            ? chat.participants.last.lastSeen
                            : chat.participants.first.lastSeen,
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
                        subtitle: "last message",
                        time: '12:15',
                        onTap: () {
                          // Open channel screen
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
                      final group = state.groups[index];
                      return GroupTile(
                        id: group.id,
                        imageUrl: group.imageUrl ?? "",
                        title: group.name,
                        subtitle: 'last message',
                        time: '12:15',
                        onTap: () {
                          // Open group screen
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
