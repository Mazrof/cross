import 'package:equatable/equatable.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';

class UserSettingsState extends Equatable {
  final CubitState state;
  final String? errorMessage;
  final String screenName;
  final String userName;
  final String phoneNumber;
  final String bio;
  final String status;

  UserSettingsState({
    this.state = CubitState.initial,
    this.errorMessage,
    this.screenName = '',
    this.userName = '',
    this.phoneNumber = '',
    this.bio = '',
    this.status = '',
  });

  UserSettingsState copyWith({
    CubitState? state,
    String? errorMessage,
    String? screenName,
    String? userName,
    String? phoneNumber,
    String? bio,
    String? status,
  }) {
    return UserSettingsState(
      state: state ?? this.state,
      errorMessage: errorMessage ?? this.errorMessage,
      screenName: screenName ?? this.screenName,
      userName: userName ?? this.userName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      bio: bio ?? this.bio,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        state,
        errorMessage,
        screenName,
        userName,
        phoneNumber,
        bio,
        status,
      ];
}
