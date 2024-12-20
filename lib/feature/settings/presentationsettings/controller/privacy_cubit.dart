import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram/core/use_cases/use_case.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/settings/domainsettings/entities/user_settings_entity.dart';
import 'package:telegram/feature/settings/domainsettings/usecases/fetch_settings_use_case.dart';
import 'package:telegram/feature/settings/domainsettings/usecases/update_settings_use_case.dart';
import 'package:telegram/feature/settings/presentationsettings/controller/privacy_state.dart';

class PrivacyCubit extends Cubit<PrivacyState> {
  final FetchSettingsUseCase fetchSettingsUseCase;
  final UpdateSettingsUseCase updateSettingsUseCase;

  PrivacyCubit({
    required this.fetchSettingsUseCase,
    required this.updateSettingsUseCase,
  }) : super(PrivacyState());

  Future<void> loadPrivacySettings() async {
    emit(state.copyWith(state: CubitState.loading));
    final result = await fetchSettingsUseCase.call(NoParameters());
    result.fold(
      (failure) => emit(state.copyWith(
          state: CubitState.failure, errorMessage: failure.message)),
      (settings) => emit(state.copyWith(
        state: CubitState.success,
        autoDeleteTimer: settings.autoDeleteTimer,
        lastSeenPrivacy: settings.lastSeenPrivacy,
        profilePhotoPrivacy: settings.profilePhotoPrivacy,
        enableReadReceipt: settings.enableReadReceipt,
        storyVisibility: settings.storyVisibility,
      )),
    );
  }

  Future<void> updatePrivacySettings({
    String? newAutoDeleteTimer,
    String? newLastSeenPrivacy,
    String? newProfilePhotoSecurity,
    String? newEnableReadReceipt,
    String? newStoryVisibility,
  }) async {
    emit(state.copyWith(state: CubitState.loading));
    final updatedSettings = UserSettingsEntity(
      autoDeleteTimer: newAutoDeleteTimer,
      lastSeenPrivacy: newLastSeenPrivacy,
      profilePhotoPrivacy: newProfilePhotoSecurity,
      enableReadReceipt: newEnableReadReceipt,
      storyVisibility: newStoryVisibility,
    );
    final result = await updateSettingsUseCase(updatedSettings);
    result.fold(
        (failure) => emit(state.copyWith(
            state: CubitState.failure, errorMessage: failure.message)),
        (_) => emit(state.copyWith(state: CubitState.success)));
  }
}
