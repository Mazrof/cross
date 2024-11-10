import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram/core/use_cases/use_case.dart';
import 'package:telegram/feature/settings/Data/model/user_settings_model.dart';
import 'package:telegram/feature/settings/Presentation/Controller/user_settings_state.dart';
import 'package:telegram/feature/settings/domain/use_cases/fetch_settings_use_case.dart';
import 'package:telegram/feature/settings/domain/use_cases/update_settings_use_case.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';

class UserSettingsCubit extends Cubit<UserSettingsState> {
  final FetchSettingsUseCase fetchSettingsUseCase;
  final UpdateSettingsUseCase updateSettingsUseCase;

  UserSettingsCubit({
    required this.fetchSettingsUseCase,
    required this.updateSettingsUseCase,
  }) : super(UserSettingsState());

  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  void loadSettings() async {
    emit(state.copyWith(state: CubitState.loading));
    final result = await fetchSettingsUseCase.call(NoParameters());
    result.fold(
      (failure) => emit(state.copyWith(
          state: CubitState.failure, errorMessage: failure.message)),
      (settings) => emit(state.copyWith(
        state: CubitState.success,
        screenName: settings.screenName,
        userName: settings.userName,
        phoneNumber: settings.phoneNumber,
        bio: settings.bio,
        status: settings.status,
      )),
    );
  }

  void saveSettings(String newScreenName, String newUserName,
      String newPhoneNumber, String newBio, String newStatus) async {
    emit(state.copyWith(state: CubitState.loading));
    final updatedSettings = UserSettingsBodyModel(
      screenName: newScreenName,
      userName: newUserName,
      phoneNumber: newPhoneNumber,
      bio: newBio,
      status: newStatus,
    );
    final result = await updateSettingsUseCase(updatedSettings);
    result.fold(
      (failure) => emit(state.copyWith(
          state: CubitState.failure, errorMessage: failure.message)),
      (_) => emit(state.copyWith(state: CubitState.success)),
    );
  }
}
