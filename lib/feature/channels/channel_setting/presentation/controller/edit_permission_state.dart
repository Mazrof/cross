import 'package:equatable/equatable.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/channels/channel_setting/data/model/membership_channel_model.dart';

class ChannelPermissionState extends Equatable {
  final MembershipChannelModel? membershipModel;
  final CubitState state;
  final String? message;

  ChannelPermissionState({
    this.membershipModel,
    this.state = CubitState.initial,
    this.message,
  });

  ChannelPermissionState copyWith({
    MembershipChannelModel? membershipModel,
    CubitState? state,
    String? message,
  }) {
    return ChannelPermissionState(
      membershipModel: membershipModel ?? this.membershipModel,
      state: state ?? this.state,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [membershipModel, state, message];
}
