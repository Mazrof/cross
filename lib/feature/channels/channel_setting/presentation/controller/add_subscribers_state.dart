import 'package:equatable/equatable.dart';
import 'package:telegram/feature/channels/create_channel/data/model/channel_model.dart';
import 'package:telegram/feature/groups/add_new_group/domain/entity/chat_tile_data.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';

class SubscribersState extends Equatable {
  final ChannelModel? channel;
  final String? errorMessage;
  final CubitState state;
  final List<chatTileData> allSubscribers;
  final List<chatTileData> selectedSubscribers;

  SubscribersState({
    this.channel,
    this.state = CubitState.initial,
    this.errorMessage,
    required this.allSubscribers,
    required this.selectedSubscribers,
  });

  SubscribersState copyWith({
    ChannelModel? channel,
    List<chatTileData>? allSubscribers,
    List<chatTileData>? selectedSubscribers,
    CubitState? state,
    String? errorMessage,
  }) {
    return SubscribersState(
      channel: channel ?? this.channel,
      state: state ?? this.state,
      errorMessage: errorMessage ?? this.errorMessage,
      allSubscribers: allSubscribers ?? this.allSubscribers,
      selectedSubscribers: selectedSubscribers ?? this.selectedSubscribers,
    );
  }

  @override
  List<Object?> get props => [
        channel,
        state,
        errorMessage,
        allSubscribers,
        selectedSubscribers,
      ];
}
