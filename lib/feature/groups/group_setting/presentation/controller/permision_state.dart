import 'package:equatable/equatable.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/groups/group_setting/data/model/membership_model.dart';

class PermisionState extends Equatable {
  final MembershipModel? membershipModel;
  final CubitState state;
  final message;

  PermisionState({
    this.membershipModel,
    this.state = CubitState.initial,
    this.message,
  });

  PermisionState copyWith({
    MembershipModel? membershipModel,
    CubitState? state,
    String? message,
  }) {
    return PermisionState(
      membershipModel: membershipModel ?? this.membershipModel,
      state: state ?? this.state,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [membershipModel, state, message];
}
