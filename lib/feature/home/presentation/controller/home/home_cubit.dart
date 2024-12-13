import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/network/api/api_service.dart';
import 'package:telegram/core/network/network_manager.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/groups/group_setting/data/model/group_setting_model.dart';
import 'package:telegram/feature/home/data/model/chat_model.dart';
import 'package:telegram/feature/home/data/model/story_model.dart';
import 'package:telegram/feature/home/domain/use_cases/fetch_channels_use_case.dart';
import 'package:telegram/feature/home/domain/use_cases/fetch_contacts_use_case.dart';
import 'package:telegram/feature/home/domain/use_cases/fetch_groups_use_case.dart';
import 'package:telegram/feature/home/domain/use_cases/fetch_story_use_case.dart';
import '../../../../channels/create_channel/data/model/channel_model.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required this.fetchStoriesUseCase,
    required this.fetchGroupsUseCase,
    required this.fetchChannelsUseCase,
    required this.fetchContactsUseCase,
    required this.networkManager,
  }) : super(HomeState());

  final FetchStoriesUseCase fetchStoriesUseCase;
  final FetchGroupsUseCase fetchGroupsUseCase;
  final FetchChannelsUseCase fetchChannelsUseCase;
  final FetchContactsUseCase fetchContactsUseCase;
  final NetworkManager networkManager;
  Future<void> loadHomeData() async {
    emit(state.copyWith(state: CubitState.loading));

    try {
      // Simultaneously fetch all required data
      // final responses = await Future.wait([
      //   fetchStories(),
      //   // fetchGroups(),
      //   // fetchChannels(),
      //   fetchContacts(),
      // ]);

      final contacts = await fetchContacts();

      final stories = await fetchStories();

      // final stories = responses[0] as List<StoryModel>;
      // final contacts = responses[1] as List<ChatModel>;
      // // final groups = responses[1] as List<GroupModel>;
      // // final channels = responses[2] as List<ChannelModel>;

      // // Sort stories by `isSeen` to display unseen stories first
      // stories.sort((a, b) => a.isSeen ? 1 : -1);

      emit(
        state.copyWith(
          state: CubitState.success,
          stories: stories,
          // groups: groups,
          // channels: channels,
          contacts: contacts,
        ),
      );
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
    // await Future.delayed(Duration(seconds: 1)); // Simulate API delay

    dynamic response = await sl<ApiService>().get(
      endPoint: "chats/my-chats",
      queryParameters: {
        "type": "personalChat",
      },
    );

    print(response);

    response = response.data as List;

    return List.generate(
      (response as List).length,
      (index) => ChatModel(
        chatId: index.toString(),
        participants: List.generate(
          1,
          (i) => Participant(
            userId: (response[index]['secondUser']['id']).toString(),
            name: response[index]['secondUser']['username'],
            lastSeen: '12:15',
          ),
        ),
        lastMessage: LastMessage(
          content: response[index]['lastMessage']['content'],
          timestamp: DateFormat('HH:mm').format(
              DateTime.parse(response[index]['lastMessage']['createdAt'])),
          messageId: (response[index]['lastMessage']['id']).toString(),
        ),
        cursor: 'cursor',
      ),
    );
  }
}
