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
  final String autoDeleteTimer;
  final String lastSeenPrivacy;
  final String profilePhotoPrivacy;
  final bool enableReadReceipt;

  UserSettingsState({
    this.state = CubitState.initial,
    this.errorMessage,
    this.screenName = '',
    this.userName = '',
    this.phoneNumber = '',
    this.bio = '',
    this.status = '',
    this.autoDeleteTimer = 'Off',
    this.lastSeenPrivacy = 'Everybody',
    this.profilePhotoPrivacy = 'Everybody',
    this.enableReadReceipt = true,
  });

  UserSettingsState copyWith({
    CubitState? state,
    String? errorMessage,
    String? screenName,
    String? userName,
    String? phoneNumber,
    String? bio,
    String? status,
    String? autoDeleteTimer,
    String? lastSeenPrivacy,
    String? profilePhotoPrivacy,
    bool? enableReadReceipt,
  }) {
    return UserSettingsState(
      state: state ?? this.state,
      errorMessage: errorMessage ?? this.errorMessage,
      screenName: screenName ?? this.screenName,
      userName: userName ?? this.userName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      bio: bio ?? this.bio,
      status: status ?? this.status,
      autoDeleteTimer: autoDeleteTimer ?? this.autoDeleteTimer,
      lastSeenPrivacy: lastSeenPrivacy ?? this.lastSeenPrivacy,
      profilePhotoPrivacy: profilePhotoPrivacy ?? this.profilePhotoPrivacy,
      enableReadReceipt: enableReadReceipt ?? this.enableReadReceipt,
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
        autoDeleteTimer,
        lastSeenPrivacy,
        profilePhotoPrivacy,
        enableReadReceipt,
      ];
}
