import 'package:equatable/equatable.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';

class UserSettingsState extends Equatable {
  final CubitState state;
  final String? errorMessage;
  final String profilePicture;
  final String screenName;
  final String userName;
  final String phoneNumber;
  final String bio;
  final int maxFileSize;
  final int maxDownloadSize;

  UserSettingsState({
    this.state = CubitState.initial,
    this.errorMessage,
    this.screenName = '',
    this.userName = '',
    this.profilePicture = '',
    this.phoneNumber = '',
    this.bio = '',
    this.maxFileSize = 0,
    this.maxDownloadSize = 0,
  });

  UserSettingsState copyWith({
    CubitState? state,
    String? errorMessage,
    String? screenName,
    String? userName,
    String? phoneNumber,
    String? profilePicture,
    String? bio,
    int? maxFileSize,
    int? maxDownloadSize,
  }) {
    return UserSettingsState(
      state: state ?? this.state,
      errorMessage: errorMessage ?? this.errorMessage,
      screenName: screenName ?? this.screenName,
      userName: userName ?? this.userName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      bio: bio ?? this.bio,
      profilePicture: profilePicture ?? this.profilePicture,
      maxFileSize: maxFileSize ?? this.maxFileSize,
      maxDownloadSize: maxDownloadSize ?? this.maxDownloadSize,
    );
  }

  @override
  List<Object?> get props => [
        state,
        errorMessage,
        profilePicture,
        screenName,
        userName,
        phoneNumber,
        bio,
        maxFileSize,
        maxDownloadSize,
      ];
}
