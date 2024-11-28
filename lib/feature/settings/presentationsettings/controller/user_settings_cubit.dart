import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram/core/network/network_manager.dart';
import 'package:telegram/core/use_cases/use_case.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/core/validator/app_validator.dart';
import 'package:telegram/feature/settings/datasettings/models/user_settings_model.dart';
import 'package:telegram/feature/settings/domainsettings/entities/user_settings_entity.dart';
import 'package:telegram/feature/settings/domainsettings/usecases/fetch_settings_use_case.dart';
import 'package:telegram/feature/settings/domainsettings/usecases/update_settings_use_case.dart';
import 'package:telegram/feature/settings/presentationsettings/controller/user_settings_state.dart';

class UserSettingsCubit extends Cubit<UserSettingsState> {
  final FetchSettingsUseCase fetchSettingsUseCase;
  final UpdateSettingsUseCase updateSettingsUseCase;
  final AppValidator appValidator;
  final NetworkManager networkManager;

  UserSettingsCubit(
      {required this.fetchSettingsUseCase,
      required this.updateSettingsUseCase,
      required this.appValidator,
      required this.networkManager})
      : super(UserSettingsState());

  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  Future<void> loadSettings() async {
    emit(state.copyWith(state: CubitState.loading));
    final result = await fetchSettingsUseCase.call(NoParameters());
    result.fold(
      (failure) => emit(state.copyWith(
          state: CubitState.failure, errorMessage: failure.message)),
      (settings) => emit(state.copyWith(
        state: CubitState.success,
        profileImage: settings.profileImage,
        screenName: settings.screenName,
        userName: settings.userName,
        phoneNumber: settings.phoneNumber,
        bio: settings.bio,
        status: settings.status,
        autoDeleteTimer: settings.autoDeleteTimer,
        lastSeenPrivacy: settings.lastSeenPrivacy,
        profilePhotoPrivacy: settings.profilePhotoPrivacy,
        enableReadReceipt: settings.enableReadReceipt,
        blockedUsers: settings.blockedUsers,
        contacts: settings.contacts,
      )),
    );
  }

  Future<void> saveSettings(
    String newProfileImage,
    String newScreenName,
    String newUserName,
    String newPhoneNumber,
    String newBio,
    String newStatus,
    String newAutoDeleteTimer,
    String newLastSeenPrivacy,
    String newProfilePhotoPrivacy,
    bool newEnableReadReceipt,
    List<String> newBlockedUsers,
    List<String> newContacts,
  ) async {
    emit(state.copyWith(state: CubitState.loading));
    final updatedSettings = UserSettingsEntity(
      profileImage: newProfileImage,
      screenName: newScreenName,
      userName: newUserName,
      phoneNumber: newPhoneNumber,
      bio: newBio,
      status: newStatus,
      autoDeleteTimer: newAutoDeleteTimer,
      lastSeenPrivacy: newLastSeenPrivacy,
      profilePhotoPrivacy: newProfilePhotoPrivacy,
      enableReadReceipt: newEnableReadReceipt,
      blockedUsers: newBlockedUsers,
      contacts: newContacts,
    );
    final result = await updateSettingsUseCase(updatedSettings);
    result.fold(
      (failure) => emit(state.copyWith(
          state: CubitState.failure, errorMessage: failure.message)),
      (_) => emit(state.copyWith(state: CubitState.success)),
    );
  }
}
