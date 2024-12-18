import 'package:bloc/bloc.dart';
import 'package:telegram/core/network/network_manager.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/groups/add_new_group/data/model/member_model.dart';
import 'package:telegram/feature/groups/group_setting/data/model/membership_model.dart';
import 'package:telegram/feature/groups/group_setting/domain/use_case/update_member_role.dart';
import 'package:telegram/feature/groups/group_setting/presentation/controller/permision_state.dart';

class PermisionCubit extends Cubit<PermisionState> {
  PermisionCubit(
    this.updateMemberRoleUseCase,
    this.networkManager,
  ) : super(PermisionState());

  void addData(MembershipModel member) {
    emit(state.copyWith(
      membershipModel: member,
      state: CubitState.success,
    ));
  }

  final UpdateMemberRoleUseCase updateMemberRoleUseCase;
  final NetworkManager networkManager;

  void editMemberData() {
    if (networkManager.isConnected() == false) {
      emit(state.copyWith(
          state: CubitState.failure, message: 'No Internet Connection'));
      return;
    }
    print(
      MemberModel(
          userId: state.membershipModel!.userId,
          role: state.membershipModel!.role,
          hasDownloadPermissions: state.membershipModel!.hasDownloadPermissions,
          hasMessagePermissions: state.membershipModel!.hasMessagePermissions),
    );

    try {
      updateMemberRoleUseCase(
        state.membershipModel!.groupId,
        MemberModel(
            userId: state.membershipModel!.userId,
            role: state.membershipModel!.role,
            hasDownloadPermissions:
                state.membershipModel!.hasDownloadPermissions,
            hasMessagePermissions:
                state.membershipModel!.hasMessagePermissions),
      );
      emit(state.copyWith(state: CubitState.success));
    } catch (e) {
      emit(state.copyWith(state: CubitState.failure, message: e.toString()));
    }
  }

  void toggleDownloadPermissions(bool value) {
    final updatedMember = state.membershipModel!.copyWith(
      hasDownloadPermissions: value,
    );
    emit(state.copyWith(
      membershipModel: updatedMember,
    ));
  }

  void toggleMessagePermissions(bool value) {
    final updatedMember = state.membershipModel!.copyWith(
      hasMessagePermissions: value,
    );
    emit(state.copyWith(
      membershipModel: updatedMember,
    ));
  }
}
