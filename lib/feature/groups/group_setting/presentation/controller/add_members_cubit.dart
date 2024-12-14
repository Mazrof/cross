import 'package:bloc/bloc.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/local/hive.dart';
import 'package:telegram/core/network/network_manager.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/groups/add_new_group/data/model/member_model.dart';
import 'package:telegram/feature/groups/add_new_group/domain/entity/chat_tile_data.dart';
import 'package:telegram/feature/groups/add_new_group/domain/use_case/add_members_use_case.dart';
import 'package:telegram/feature/groups/group_setting/data/model/group_setting_model.dart';
import 'package:telegram/feature/groups/group_setting/presentation/controller/add_members_state.dart';
import 'package:telegram/feature/home/data/model/chat_model.dart';
import 'package:telegram/feature/home/presentation/controller/home/home_cubit.dart';

class MembersCubit extends Cubit<MembersState> {
  MembersCubit(
    this.addMemberUseCase,
    this.networkManager,
  ) : super(MembersState(
          state: CubitState.initial,
          allMembers: [],
          selectedMembers: [],
        ));

  final AddMembersUseCase addMemberUseCase;
  final NetworkManager networkManager;

  List<chatTileData> convertChatModelToChatTileData(
      List<ChatModel> chats, String currentUserId) {
    return chats.map((chat) {
    
      return chatTileData(
        id: chat.id,
        name: chat.secondUser.username,
        imageUrl: chat.secondUser.photo??'',
        lastSeen: chat.secondUser.lastSeen.toString(),
      );
    }).toList();
  }

  void fetchGroupDetails(
    GroupModel group,
  ) async {
    final int id = HiveCash.read(boxName: "register_info", key: "id");
    List<chatTileData> members = convertChatModelToChatTileData(
        sl<HomeCubit>().state.contacts, id.toString());

    emit(MembersState(
      allMembers: members,
      selectedMembers: [],
      group: group,
    ));
  }

  void toggleMember(chatTileData member) {
    final selectedMembers = List<chatTileData>.from(state.selectedMembers);

    if (selectedMembers.contains(member)) {
      selectedMembers.remove(member);
    } else {
      selectedMembers.add(member);
    }

    emit(state.copyWith(
        selectedMembers: selectedMembers, state: CubitState.initial));
  }

  void addMember() async {
    print('going to add member');
    try {
      if (networkManager.isConnected() == false) {
        emit(state.copyWith(
            state: CubitState.failure, errorMessage: 'No Internet Connection'));
        return;
      }
      await addMemberUseCase(
          state.group!.id,
          state.selectedMembers.map((e) {
            return MemberModel(
              userId: e.id,
              role: 'member',
              hasDownloadPermissions: true,
              hasMessagePermissions: true,
            );
          }).toList());
    } catch (e) {
      emit(state.copyWith(
        state: CubitState.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
