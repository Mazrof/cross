import 'package:equatable/equatable.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';

class PrivacyState extends Equatable {
  final CubitState state;
  final String? errorMessage;
  final String autoDeleteTimer;
  final String lastSeenPrivacy;
  final String profilePhotoPrivacy;
  final String enableReadReceipt;
  final String storyVisibility;

  PrivacyState({
    this.state = CubitState.initial,
    this.errorMessage,
    this.profilePhotoPrivacy = '',
    this.lastSeenPrivacy = '',
    this.autoDeleteTimer = '',
    this.enableReadReceipt = '',
    this.storyVisibility = '',
  });

  PrivacyState copyWith({
    CubitState? state,
    String? errorMessage,
    String? autoDeleteTimer,
    String? lastSeenPrivacy,
    String? profilePhotoPrivacy,
    String? enableReadReceipt,
    String? storyVisibility,
  }) {
    return PrivacyState(
      state: state ?? this.state,
      errorMessage: errorMessage ?? this.errorMessage,
      autoDeleteTimer: autoDeleteTimer ?? this.autoDeleteTimer,
      lastSeenPrivacy: lastSeenPrivacy ?? this.lastSeenPrivacy,
      profilePhotoPrivacy: profilePhotoPrivacy ?? this.profilePhotoPrivacy,
      enableReadReceipt: enableReadReceipt ?? this.enableReadReceipt,
      storyVisibility: storyVisibility ?? this.storyVisibility,
    );
  }

  @override
  List<Object?> get props => [
        state,
        errorMessage,
        autoDeleteTimer,
        lastSeenPrivacy,
        profilePhotoPrivacy,
        enableReadReceipt,
        storyVisibility,
      ];
}
