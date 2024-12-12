
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/channels/create_channel/data/model/channel_model.dart';
import 'package:telegram/feature/groups/group_setting/data/model/group_setting_model.dart';
import 'package:telegram/feature/home/data/model/chat_model.dart';
import 'package:telegram/feature/home/data/model/story_model.dart';


class HomeState {
  final CubitState state;
  final List<StoryModel> stories;
  final List<GroupModel> groups;
  final List<ChannelModel> channels;
  final List<ChatModel> contacts;
  final String errorMessage;

  HomeState({
    this.state = CubitState.initial,
    this.stories = const [],
    this.groups = const [],
    this.channels = const [],
    this.contacts = const [],
    this.errorMessage = '',
  });

  HomeState copyWith({
    CubitState? state,
    List<StoryModel>? stories,
    List<GroupModel>? groups,
    List<ChannelModel>? channels,
    List<ChatModel>? contacts,
    String? errorMessage,
  }) {
    return HomeState(
      state: state ?? this.state,
      stories: stories ?? this.stories,
      groups: groups ?? this.groups,
      channels: channels ?? this.channels,
      contacts: contacts ?? this.contacts,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
