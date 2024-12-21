import 'package:equatable/equatable.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/channels/create_channel/data/model/channel_model.dart';
import 'package:telegram/feature/groups/group_setting/data/model/group_setting_model.dart';
import 'package:telegram/feature/home/data/model/channel_data_model.dart';
import 'package:telegram/feature/home/data/model/chat_model.dart';
import 'package:telegram/feature/home/data/model/group_data_model.dart';
import 'package:telegram/feature/home/data/model/story_model.dart';
import 'package:telegram/feature/messaging/data/model/message.dart';

class HomeState extends Equatable {
  final CubitState state;
  final List<StoryModel> stories;
  final List<GroupDataModel> groups;
  final List<ChannelDataModel> channels;
  final List<ChatModel> contacts;
  final List<Message> draftedMessages;
  final List<Message> sentMessages;
  final String errorMessage;

  HomeState({
    this.state = CubitState.initial,
    this.stories = const [],
    this.groups = const [],
    this.channels = const [],
    this.contacts = const [],
    this.draftedMessages = const [],
    this.sentMessages = const [],
    this.errorMessage = '',
  });

  HomeState copyWith({
    CubitState? state,
    List<StoryModel>? stories,
    List<GroupDataModel>? groups,
    List<ChannelDataModel>? channels,
    List<ChatModel>? contacts,
    String? errorMessage,
    List<Message>? draftedMessages,
    List<Message>? sentMessages,
  }) {
    return HomeState(
      state: state ?? this.state,
      stories: stories ?? this.stories,
      groups: groups ?? this.groups,
      channels: channels ?? this.channels,
      contacts: contacts ?? this.contacts,
      errorMessage: errorMessage ?? this.errorMessage,
      draftedMessages: draftedMessages ?? this.draftedMessages,
      sentMessages: sentMessages ?? this.sentMessages,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        state,
        stories,
        groups,
        channels,
        contacts,
        errorMessage,
        draftedMessages,
        sentMessages,
      ];
}
