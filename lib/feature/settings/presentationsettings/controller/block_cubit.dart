import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram/core/use_cases/use_case.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/settings/domainsettings/entities/user_settings_entity.dart';
import 'package:telegram/feature/settings/domainsettings/usecases/block_user_use_case.dart';
import 'package:telegram/feature/settings/domainsettings/usecases/fetch_settings_use_case.dart';
import 'package:telegram/feature/settings/domainsettings/usecases/get_blocked_users_use_case.dart';
import 'package:telegram/feature/settings/domainsettings/usecases/get_contacts_use_case.dart';
import 'package:telegram/feature/settings/domainsettings/usecases/unblock_user_use_case.dart';
import 'package:telegram/feature/settings/domainsettings/usecases/update_settings_use_case.dart';
import 'package:telegram/feature/settings/presentationsettings/controller/block_state.dart';

class BlockCubit extends Cubit<BlockState> {
  final GetBlockedUsersUseCase getBlockedUsersUseCase;
  final BlockUserUseCase blockUserUseCase;
  final GetContactsUseCase getContactsUseCase;
  final UnblockUserUseCase unblockUserUseCase;

  BlockCubit({
    required this.getBlockedUsersUseCase,
    required this.getContactsUseCase,
    required this.blockUserUseCase,
    required this.unblockUserUseCase,
  }) : super(BlockState());

  Future<void> loadBlockedData() async {
    emit(state.copyWith(state: CubitState.loading));
    final result = await getBlockedUsersUseCase.call(NoParameters());
    result.fold(
      (failure) => emit(state.copyWith(
          state: CubitState.failure, errorMessage: failure.message)),
      (settings) => emit(state.copyWith(
        blockedUsers: settings.blockedUsers,
      )),
    );
  }

  Future<void> loadContacts() async {
    emit(state.copyWith(state: CubitState.loading));
    final result = await getContactsUseCase.call(NoParameters());
    result.fold(
      (failure) => emit(state.copyWith(
          state: CubitState.failure, errorMessage: failure.message)),
      (settings) => emit(state.copyWith(
        contacts: settings.contacts,
      )),
    );
  }

  Future<void> blockUser(int blockedId) async {
    emit(state.copyWith(state: CubitState.loading));
    final result = await blockUserUseCase.call(blockedId);
    result.fold(
      (failure) => emit(state.copyWith(
        state: CubitState.failure,
        errorMessage: failure.message,
      )),
      (_) => emit(state.copyWith(state: CubitState.success)),
    );
  }

  Future<void> unBlockUser(int blockedId) async {
    emit(state.copyWith(state: CubitState.loading));
    final result = await unblockUserUseCase.call(blockedId);
    result.fold(
      (failure) => emit(state.copyWith(
        state: CubitState.failure,
        errorMessage: failure.message,
      )),
      (_) => emit(state.copyWith(state: CubitState.success)),
    );
  }
}
