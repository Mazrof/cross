import 'package:bloc/bloc.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/local/hive.dart';
import 'package:telegram/core/network/network_manager.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/channels/channel_setting/data/model/membership_channel_model.dart';
import 'package:telegram/feature/channels/channel_setting/domain/use_case/delete_channel_use_case.dart';
import 'package:telegram/feature/channels/channel_setting/domain/use_case/fetch_channel_data_use_case.dart';
import 'package:telegram/feature/channels/channel_setting/domain/use_case/fetch_channel_subscriber_use_case.dart';
import 'package:telegram/feature/channels/channel_setting/domain/use_case/remove_subscriber_use_case.dart';
import 'package:telegram/feature/channels/channel_setting/domain/use_case/updatae_subscriber_role_use_case.dart';
import 'package:telegram/feature/channels/channel_setting/domain/use_case/update_channel_use_case.dart';
import 'package:telegram/feature/channels/channel_setting/presentation/controller/channel_setting_state.dart';
import 'package:telegram/feature/channels/create_channel/data/model/channel_model.dart';
import 'package:telegram/feature/groups/add_new_group/domain/entity/chat_tile_data.dart';

import 'package:telegram/feature/home/data/model/chat_model.dart';
import 'package:telegram/feature/home/presentation/controller/home/home_cubit.dart';

class ChannelSettingCubit extends Cubit<ChannelSettingState> {
  ChannelSettingCubit(
    this.fetchChannelDetailsUseCase,
    this.updateSubscriberRoleUseCase,
    this.removeMemberUseCase,
    this.deleteChannelUseCase,
    this.updateChannelDetailsUseCase,
    this.networkManager,
    this.fetchChannelMembersUseCase,
  ) : super(ChannelSettingState(
          state: CubitState.initial,
          isMuted: false,
          channel: ChannelModel.empty(),
          members: [],
        ));

  final FetchChannelDetailsUseCase fetchChannelDetailsUseCase;
  final UpdateSubscriberRoleUseCase updateSubscriberRoleUseCase;
  final RemoveSubscriberUseCase removeMemberUseCase;
  final DeleteChannelUseCase deleteChannelUseCase;
  final UpdateChannelDetailsUseCase updateChannelDetailsUseCase;
  final NetworkManager networkManager;
  final FetchChannelSubscriberUseCase fetchChannelMembersUseCase;

  List<chatTileData> convertChatModelToChatTileData(
      List<ChatModel> chats, String currentUserId) {
    return chats.map((chat) {
      return chatTileData(
        id: chat.secondUser.id,
        name: chat.secondUser.username,
        imageUrl: chat.secondUser.photo ?? '',
        lastSeen: chat.secondUser.lastSeen.toString(),
      );
    }).toList();
  }

  void toggleComments(int channelId, bool val) async {
    try {
      if (networkManager.isConnected() == false) {
        emit(state.copyWith(
            state: CubitState.failure, error: 'No Internet Connection'));
        return;
      }
      emit(state.copyWith(state: CubitState.loading));
      print('toggling coments');
      print(state);
      final updatedGroup = state.channel!.copyWith(canAddComments: val);
      

      emit(state.copyWith(channel: updatedGroup, state: CubitState.success));

      await updateChannelDetailsUseCase(
          channelId,
          ChannelModel(
            id: channelId,
            name: state.channel!.name,
            privacy: val,
            imageUrl: state.channel!.imageUrl,
            canAddComments: state.channel!.canAddComments,
          ));
    } catch (e) {
      emit(state.copyWith(
        state: CubitState.failure,
        error: e.toString(),
      ));
    }
  }

  void togglePrivacy(int channelId, bool val) async {
    try {
      if (networkManager.isConnected() == false) {
        emit(state.copyWith(
            state: CubitState.failure, error: 'No Internet Connection'));
        return;
      }
      emit(state.copyWith(state: CubitState.loading));
      print('toggling privacy');
      print(state);
      final updatedGroup = state.channel!.copyWith(privacy: val);
      print(updatedGroup.privacy);

      emit(state.copyWith(channel: updatedGroup, state: CubitState.success));

      await updateChannelDetailsUseCase(
          channelId,
          ChannelModel(
            id: channelId,
            name: state.channel!.name,
            privacy: val,
            imageUrl: state.channel!.imageUrl,
            canAddComments: state.channel!.canAddComments,
          ));
    } catch (e) {
      emit(state.copyWith(
        state: CubitState.failure,
        error: e.toString(),
      ));
    }
  }

  void fetchChannelDetails(int channelId) async {
    // final int id = HiveCash.read(boxName: "register_info", key: "id");
    // List<chatTileData> members = convertChatModelToChatTileData(
    //     sl<HomeCubit>().state.contacts, id.toString());

    emit(state.copyWith(state: CubitState.loading, members: [], channel: null));

    if (networkManager.isConnected() == false) {
      emit(state.copyWith(
          state: CubitState.failure, error: 'No Internet Connection'));
      return;
    }
    

    try {
      print('start getting channel details in the cubit ');
      final channel = await fetchChannelDetailsUseCase(channelId);
      print('after the channel fetch ');
      print(channel);
      final members = await fetchChannelMembersUseCase(channelId);
      print(members);
      emit(state.copyWith(
        state: CubitState.success,
        channel: channel,
        members: members,
      ));
    } catch (e) {
      emit(state.copyWith(
        state: CubitState.failure,
        error: e.toString(),
      ));
    }
  }

  void updateMemberRole(MembershipChannelModel member) async {
    try {
      if (networkManager.isConnected() == false) {
        emit(state.copyWith(
            state: CubitState.failure, error: 'No Internet Connection'));
        return;
      }

      // emit(state.copyWith(state: CubitState.loading));
      print('updating member role');

      await updateSubscriberRoleUseCase(member.channelId, member);

      fetchChannelDetails(state.channel!.id);
    } catch (e) {
      emit(state.copyWith(
        state: CubitState.failure,
        error: e.toString(),
      ));
    }
  }

  void removeMember(int channelId, int memberId) async {
    try {
      if (networkManager.isConnected() == false) {
        emit(state.copyWith(
            state: CubitState.failure, error: 'No Internet Connection'));
        return;
      }

      // emit(state.copyWith(state: CubitState.loading));
      await removeMemberUseCase(state.channel!.id, memberId);
      final updatedMembers =
          state.members.where((m) => m.userId != memberId).toList();
      emit(state.copyWith(members: updatedMembers));

      fetchChannelDetails(state.channel!.id);
    } catch (e) {
      emit(state.copyWith(
        state: CubitState.failure,
        error: e.toString(),
      ));
    }
  }

  void leaveChannel(int channelId, int memberId) async {
    try {
      if (networkManager.isConnected() == false) {
        emit(state.copyWith(
            state: CubitState.failure, error: 'No Internet Connection'));
        return;
      }

      emit(state.copyWith(state: CubitState.loading));
      await removeMemberUseCase(channelId, memberId);

      // Handle leaving the channel, e.g., navigate to another screen
    } catch (e) {
      emit(state.copyWith(
        state: CubitState.failure,
        error: e.toString(),
      ));
    }
  }

  void deleteChannel(int channelId) async {
    try {
      if (networkManager.isConnected() == false) {
        emit(state.copyWith(
            state: CubitState.failure, error: 'No Internet Connection'));
        return;
      }

      emit(state.copyWith(state: CubitState.loading));
      await deleteChannelUseCase(channelId);

      // Handle channel deletion, e.g., navigate to another screen
    } catch (e) {
      emit(state.copyWith(
        state: CubitState.failure,
        error: e.toString(),
      ));
    }
  }

  void updateChannelDetails(int channelId, ChannelModel data) async {
    try {
      if (networkManager.isConnected() == false) {
        emit(state.copyWith(
            state: CubitState.failure, error: 'No Internet Connection'));
        return;
      }

      // emit(state.copyWith(state: CubitState.loading));
      await updateChannelDetailsUseCase(channelId, data);
      final updatedChannel = state.channel!.copyWith(
        name: data.name,
        privacy: data.privacy,
        imageUrl: data.imageUrl,
      );
      emit(state.copyWith(channel: updatedChannel));
      fetchChannelDetails(channelId);
    } catch (e) {
      emit(state.copyWith(
        state: CubitState.failure,
        error: e.toString(),
      ));
    }
  }
}
