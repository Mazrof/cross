import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram/core/local/hive.dart';
import 'package:telegram/core/network/network_manager.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/home/data/model/channel_data_model.dart';
import 'package:telegram/feature/home/data/model/chat_model.dart';
import 'package:telegram/feature/home/data/model/group_data_model.dart';
import 'package:telegram/feature/home/data/model/story_model.dart';
import 'package:telegram/feature/home/domain/use_cases/fetch_channels_use_case.dart';
import 'package:telegram/feature/home/domain/use_cases/fetch_contacts_use_case.dart';
import 'package:telegram/feature/home/domain/use_cases/fetch_groups_use_case.dart';
import 'package:telegram/feature/home/domain/use_cases/fetch_story_use_case.dart';
import 'package:telegram/feature/messaging/data/model/message.dart';
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
      final responses = await Future.wait([
        fetchStories(),
        fetchGroups(),
        fetchChannels(),
        fetchContacts(),
        fetchDraftedMessages(),
      ]);

      final stories = responses[0] as List<StoryModel>;
      final groups = responses[1] as List<GroupDataModel>;
      final channels = responses[2] as List<ChannelDataModel>;
      final contacts = responses[3] as List<ChatModel>;

      final draftedMessages = responses[4] as List<Message>;

      print('formt the cubit ${contacts}');

      // Sort stories by `isSeen` to display unseen stories first
      stories.sort((a, b) => a.isSeen ? 1 : -1);

      emit(
        state.copyWith(
          state: CubitState.success,
          stories: stories,
          groups: groups,
          channels: channels,
          contacts: contacts,
          draftedMessages: draftedMessages,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        state: CubitState.failure,
        errorMessage: e.toString() ?? 'An error occurred',
      ));
    }
  }

  Future<List<StoryModel>> fetchStories() async {
    // Replace with your API call

    try {
      if (networkManager.isConnected() == 'false') {
        emit(state.copyWith(
            state: CubitState.failure, errorMessage: 'No internet connection'));
        return [];
      }

      final stories = await fetchStoriesUseCase();
      return stories;
    } catch (e) {
      print('error from cubit $e');
      return [];
    }
  }

  Future<List<GroupDataModel>> fetchGroups() async {
    // Replace with your API call
    print('fetching groups');

    try {
      if (networkManager.isConnected() == 'false') {
        emit(state.copyWith(
            state: CubitState.failure, errorMessage: 'No internet connection'));
        return [];
      }

      final groups = await fetchGroupsUseCase();
      print('groups from cubit ${groups}');
      return groups;
    } catch (e) {
      print('error from cubit $e');
      return [];
    }
  }

  Future<List<ChannelDataModel>> fetchChannels() async {
    // Replace with your API call
    print('fetching channels');
    try {
      if (networkManager.isConnected() == 'false') {
        emit(state.copyWith(
            state: CubitState.failure, errorMessage: 'No internet connection'));
        return [];
      }

      final channels = await fetchChannelsUseCase();
      return channels;
    } catch (e) {
      print('error from cubit $e');
      return [];
    }
  }

  Future<List<ChatModel>> fetchContacts() async {
    print('fetching contacts');
    // Replace with your API call
    try {
      if (networkManager.isConnected() == 'false') {
        emit(state.copyWith(
            state: CubitState.failure, errorMessage: 'No internet connection'));
        return [];
      }

      final contacts = await fetchContactsUseCase();
      return contacts;
    } catch (e) {
      print('error from cubit $e');
      return [];
    }
  }

  Future<List<Message>> fetchDraftedMessages() async {
    List<dynamic> temp =
        await HiveCash.read(boxName: "messages", key: 'drafted_messages');

    if (temp == null) {
      return [];
    } else {
      return temp.map((item) => item as Message).toList();
    }
  }
}
