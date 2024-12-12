import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/groups/group_setting/data/model/group_setting_model.dart';
import 'package:telegram/feature/home/data/model/chat_model.dart';
import 'package:telegram/feature/home/data/model/story_model.dart';
import '../../../../channels/create_channel/data/model/channel_model.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());

  Future<void> loadHomeData() async {
    emit(state.copyWith(state: CubitState.loading));

    try {
      // Simultaneously fetch all required data
      final responses = await Future.wait([
        fetchStories(),
        fetchGroups(),
        fetchChannels(),
        fetchContacts(),
      ]);

      final stories = responses[0] as List<StoryModel>;
      final groups = responses[1] as List<GroupModel>;
      final channels = responses[2] as List<ChannelModel>;
      final contacts = responses[3] as List<ChatModel>;

      // Sort stories by `isSeen` to display unseen stories first
      stories.sort((a, b) => a.isSeen ? 1 : -1);

      emit(state.copyWith(
        state: CubitState.success,
        stories: stories,
        groups: groups,
        channels: channels,
        contacts: contacts,
      ));
    } catch (e) {
      emit(state.copyWith(
          state: CubitState.failure, errorMessage: e.toString()));
    }
  }

  Future<List<StoryModel>> fetchStories() async {
    // Replace with your API call
    await Future.delayed(Duration(seconds: 1)); // Simulate API delay
    return [
      StoryModel(
        id: '1',
        createdAt: DateTime.now().subtract(Duration(hours: 1)),
        viewCount: 120,
        status: 'active',
        mediaType: 'image',
        mediaUrl: 'https://example.com/story1.jpg',
        content: 'Story content',
        userName: 'Alice',
        userImage: '',
        isSeen: false,
        isOwner: false,
      ),
      StoryModel(
        id: '1',
        createdAt: DateTime.now().subtract(Duration(hours: 1)),
        viewCount: 120,
        status: 'active',
        mediaType: 'image',
        mediaUrl: 'https://example.com/story1.jpg',
        content: 'Story content',
        userName: 'Alice',
        userImage: '',
        isSeen: false,
        isOwner: false,
      ),
      StoryModel(
        id: '1',
        createdAt: DateTime.now().subtract(Duration(hours: 1)),
        viewCount: 120,
        status: 'active',
        mediaType: 'image',
        mediaUrl: 'https://example.com/story1.jpg',
        content: 'Story content',
        userName: 'Alice',
        userImage: '',
        isSeen: false,
        isOwner: false,
      ),
      StoryModel(
        id: '1',
        createdAt: DateTime.now().subtract(Duration(hours: 1)),
        viewCount: 120,
        status: 'active',
        mediaType: 'image',
        mediaUrl: 'https://example.com/story1.jpg',
        content: 'Story content',
        userName: 'Alice',
        userImage: '',
        isSeen: false,
        isOwner: false,
      ),
      StoryModel(
        id: '1',
        createdAt: DateTime.now().subtract(Duration(hours: 1)),
        viewCount: 120,
        status: 'active',
        mediaType: 'image',
        mediaUrl: 'https://example.com/story1.jpg',
        content: 'Story content',
        userName: 'Alice',
        userImage: '',
        isSeen: false,
        isOwner: false,
      ),
      StoryModel(
        id: '1',
        createdAt: DateTime.now().subtract(Duration(hours: 1)),
        viewCount: 120,
        status: 'active',
        mediaType: 'image',
        mediaUrl: 'https://example.com/story1.jpg',
        content: 'Story content',
        userName: 'Alice',
        userImage: '',
        isSeen: false,
        isOwner: false,
      ),
      StoryModel(
        id: '1',
        createdAt: DateTime.now().subtract(Duration(hours: 1)),
        viewCount: 120,
        status: 'active',
        mediaType: 'image',
        mediaUrl: 'https://example.com/story1.jpg',
        content: 'Story content',
        userName: 'Alice',
        userImage: '',
        isSeen: false,
        isOwner: false,
      ),
      StoryModel(
        id: '1',
        createdAt: DateTime.now().subtract(Duration(hours: 1)),
        viewCount: 120,
        status: 'active',
        mediaType: 'image',
        mediaUrl: 'https://example.com/story1.jpg',
        content: 'Story content',
        userName: 'Alice',
        userImage: '',
        isSeen: false,
        isOwner: false,
      ),
    ];
  }

  Future<List<GroupModel>> fetchGroups() async {
    // Replace with your API call
    await Future.delayed(Duration(seconds: 1)); // Simulate API delay
    return [
      GroupModel(
        id: 102,
        groupSize: 14,
        name: 'Group Name',
        privacy: true,
        imageUrl: "https://example.com/group-image.jpg",
      ),
      GroupModel(
        id: 102,
        groupSize: 14,
        name: 'Group Name',
        privacy: true,
        imageUrl: "https://example.com/group-image.jpg",
      ),
      GroupModel(
        id: 102,
        groupSize: 14,
        name: 'Group Name',
        privacy: true,
        imageUrl: "https://example.com/group-image.jpg",
      ),
      GroupModel(
        id: 102,
        groupSize: 14,
        name: 'Group Name',
        privacy: true,
        imageUrl: "https://example.com/group-image.jpg",
      ),
    ];
  }

  Future<List<ChannelModel>> fetchChannels() async {
    // Replace with your API call
    await Future.delayed(Duration(seconds: 1)); // Simulate API delay
    return [
      ChannelModel(
        id: 1,
        canAddComments: true,
        name: 'General Chat',
        privacy: true,
        imageUrl: 'https://example.com/channel-image.jpg',
      ),
      ChannelModel(
        id: 1,
        canAddComments: true,
        name: 'General Chat',
        privacy: true,
        imageUrl: 'https://example.com/channel-image.jpg',
      ),
      ChannelModel(
        id: 1,
        canAddComments: true,
        name: 'General Chat',
        privacy: true,
        imageUrl: 'https://example.com/channel-image.jpg',
      ),
      ChannelModel(
        id: 1,
        canAddComments: true,
        name: 'General Chat',
        privacy: true,
        imageUrl: 'https://example.com/channel-image.jpg',
      ),
    ];
  }

  Future<List<ChatModel>> fetchContacts() async {
    // Replace with your API call
    await Future.delayed(Duration(seconds: 1)); // Simulate API delay
    return List.generate(
        10,
        (index) => ChatModel(
              chatId: index.toString(),
              participants: List.generate(
                  3,
                  (index) => Participant(
                        userId: index.toString(),
                        name: 'Participant $index',
                        lastSeen: '12:15',
                      )),
              lastMessage: LastMessage(
                content: 'Last message content',
                timestamp: "12:15",
                messageId: index.toString(),
              ),
              cursor: 'cursor',
            ));
  }
}
