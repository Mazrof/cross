import 'package:bloc/bloc.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/groups/group_setting/data/model/membership_model.dart';
import 'package:telegram/feature/groups/group_setting/presentation/controller/permision_state.dart';

class PermisionCubit extends Cubit<PermisionState> {
  PermisionCubit() : super(PermisionState());

  void addData(MembershipModel member) {
    emit(state.copyWith(
      membershipModel: member,
      state: CubitState.success,
    ));
  }

  void editMemberData() {
    // final updatedMember = state.membershipModel.copyWith(
    //   hasDownloadPermissions: hasDownloadPermissions,
    //   hasMessagePermissions: hasMessagePermissions,
    // );

    // emit(state.copyWith(
    //   membershipModel: updatedMember,
    //   state: CubitState.success,
    // ));
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
