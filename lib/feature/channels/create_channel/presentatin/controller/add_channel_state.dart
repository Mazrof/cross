import 'package:equatable/equatable.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/channels/create_channel/data/model/channel_model.dart';
import 'package:telegram/feature/home/data/model/chat_model.dart';

class AddChannelState extends Equatable {
  final String channelName;
  final String? channelImageUrl;
  final List<ChatModel> selectedSubscribers;
  final List<ChatModel> allSubscribers;
  final CubitState state;
  final String? errorMessage;
  final ChannelModel? channel;
  final bool privacy;

  const AddChannelState({
    required this.channelName,
    this.channelImageUrl,
    required this.selectedSubscribers,
    required this.allSubscribers,
    required this.state,
    this.errorMessage,
    this.channel,
    this.privacy = false,
  });

  factory AddChannelState.initial() {
    return AddChannelState(
      channelName: '',
      selectedSubscribers: [],
      allSubscribers: [],
      state: CubitState.initial,
      privacy: false,
      
    );
  }

  AddChannelState copyWith({
    String? channelName,
    String? channelImageUrl,
    List<ChatModel>? selectedSubscribers,
    List<ChatModel>? allSubscribers,
    CubitState? state,
    String? errorMessage,
    ChannelModel? channel,
    bool? privacy,
  }) {
    return AddChannelState(
      channelName: channelName ?? this.channelName,
      channelImageUrl: channelImageUrl ?? this.channelImageUrl,
      selectedSubscribers: selectedSubscribers ?? this.selectedSubscribers,
      allSubscribers: allSubscribers ?? this.allSubscribers,
      state: state ?? this.state,
      errorMessage: errorMessage ?? this.errorMessage,
      channel: channel ?? this.channel,
      privacy: privacy ?? this.privacy,
    );
  }

  @override
  List<Object?> get props => [
        channelName,
        channelImageUrl,
        selectedSubscribers,
        allSubscribers,
        state,
        errorMessage,
        channel,
      ];
}
