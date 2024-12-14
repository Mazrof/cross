import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram/core/use_cases/use_case.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/settings/domainsettings/entities/user_settings_entity.dart';
import 'package:telegram/feature/settings/domainsettings/usecases/fetch_settings_use_case.dart';
import 'package:telegram/feature/settings/domainsettings/usecases/update_settings_use_case.dart';
import 'package:telegram/feature/settings/presentationsettings/controller/block_state.dart';

class BlockCubit extends Cubit<BlockState> {
  final FetchSettingsUseCase fetchSettingsUseCase;
  final UpdateSettingsUseCase updateSettingsUseCase;

  BlockCubit({
    required this.fetchSettingsUseCase,
    required this.updateSettingsUseCase,
  }) : super(BlockState());

  Future<void> loadBlockedData() async {
    emit(state.copyWith(state: CubitState.loading));
    final result = await fetchSettingsUseCase.call(NoParameters());
    result.fold(
      (failure) => emit(state.copyWith(
          state: CubitState.failure, errorMessage: failure.message)),
      (settings) => emit(state.copyWith(
        blockedUsers: settings.blockedUsers,
        contacts: settings.contacts,
      )),
    );
  }

  Future<void> updateBlockedData(
      {List<String>? newBlockedUsers, List<String>? newContacts}) async {
    emit(state.copyWith(state: CubitState.loading));
    final updatedData = UserSettingsEntity(
      blockedUsers: newBlockedUsers,
      contacts: newContacts,
    );
    final result = await updateSettingsUseCase(updatedData);
    result.fold(
      (failure) => emit(state.copyWith(
          state: CubitState.failure, errorMessage: failure.message)),
      (_) => emit(state.copyWith(state: CubitState.success)),
    );
  }
}
