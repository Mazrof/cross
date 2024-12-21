import 'package:equatable/equatable.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/channels/channel_setting/data/model/membership_channel_model.dart';
import 'package:telegram/feature/channels/create_channel/data/model/channel_model.dart';
import 'package:telegram/feature/groups/add_new_group/domain/entity/chat_tile_data.dart';

class ChannelSettingState extends Equatable {
  final CubitState state;
  final bool isMuted;
  final ChannelModel? channel;
  final List<MembershipChannelModel> members;
  final String error;

  const ChannelSettingState({
    required this.state,
    required this.isMuted,
    required this.channel,
    required this.members,
    this.error = '',
  });

  ChannelSettingState copyWith({
    CubitState? state,
    List<chatTileData>? allMembers,
    List<chatTileData>? selectedMembers,
    bool? isMuted,
    ChannelModel? channel,
    List<MembershipChannelModel>? members,
    String? error,
  }) {
    return ChannelSettingState(
      state: state ?? this.state,
      isMuted: isMuted ?? this.isMuted,
      channel: channel ?? this.channel,
      members: members ?? this.members,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        state,
        isMuted,
        channel,
        members,
        error,
      ];
}
