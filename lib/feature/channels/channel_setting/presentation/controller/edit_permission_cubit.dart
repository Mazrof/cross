import 'package:bloc/bloc.dart';
import 'package:telegram/core/network/network_manager.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/channels/channel_setting/data/model/membership_channel_model.dart';
import 'package:telegram/feature/channels/channel_setting/domain/use_case/updatae_subscriber_role_use_case.dart';
import 'package:telegram/feature/channels/channel_setting/presentation/controller/edit_permission_state.dart';

class ChannelPermissionCubit extends Cubit<ChannelPermissionState> {
  ChannelPermissionCubit(
    this.updateMemberRoleUseCase,
    this.networkManager,
  ) : super(ChannelPermissionState());

  final UpdateSubscriberRoleUseCase updateMemberRoleUseCase;
  final NetworkManager networkManager;

  void addData(MembershipChannelModel member) {
    emit(state.copyWith(
      membershipModel: member,
      state: CubitState.success,
    ));
  }

  void editMemberData() {
    if (networkManager.isConnected() == false) {
      emit(state.copyWith(
          state: CubitState.failure, message: 'No Internet Connection'));
      return;
    }
    print(
      MembershipChannelModel(
          userId: state.membershipModel!.userId,
          channelId: state.membershipModel!.channelId,
          active: state.membershipModel!.active,
          hasDownloadPermissions: state.membershipModel!.hasDownloadPermissions,
          role: state.membershipModel!.role,
          username: state.membershipModel!.username),
    );

    try {
      updateMemberRoleUseCase(
        state.membershipModel!.channelId,
        MembershipChannelModel(
            userId: state.membershipModel!.userId,
            channelId: state.membershipModel!.channelId,
            active: state.membershipModel!.active,
            hasDownloadPermissions:
                state.membershipModel!.hasDownloadPermissions,
            role: state.membershipModel!.role,
            username: state.membershipModel!.username),
      );
      emit(state.copyWith(state: CubitState.success));
    } catch (e) {
      emit(state.copyWith(state: CubitState.failure, message: e.toString()));
    }
  }

  void toggleMessageing(bool value) {
    final updatedMember = state.membershipModel!.copyWith(
      hasDownloadPermissions: value,
    );
    emit(state.copyWith(
      membershipModel: updatedMember,
    ));
  }
}
