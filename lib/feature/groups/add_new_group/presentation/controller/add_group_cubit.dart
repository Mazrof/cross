import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/local/hive.dart';
import 'package:telegram/core/network/network_manager.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/groups/add_new_group/data/model/groups_model.dart';
import 'package:telegram/feature/groups/add_new_group/data/model/member_model.dart';
import 'package:telegram/feature/groups/add_new_group/domain/entity/chat_tile_data.dart';
import 'package:telegram/feature/groups/add_new_group/domain/use_case/add_members_use_case.dart';
import 'package:telegram/feature/groups/add_new_group/domain/use_case/create_group_use_case.dart';
import 'package:telegram/feature/groups/add_new_group/presentation/controller/add_group_state.dart';
import 'package:telegram/feature/home/data/model/chat_model.dart';
import 'package:telegram/feature/home/presentation/controller/home/home_cubit.dart';

class AddMembersCubit extends Cubit<AddMembersState> {
  AddMembersCubit(
    this.createGroupUseCase,
    this.networkManager,
    this.addMembersUseCase,
  ) : super(AddMembersState(
          groupName: '',
          selectedMembers: [],
          state: GroupStatus.initial,
          errorMessage: '',
        ));

  final NetworkManager networkManager;
  final CreateGroupUseCase createGroupUseCase;
  final AddMembersUseCase addMembersUseCase;
  final ImagePicker _picker = ImagePicker();
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  void loadMembers() {
    print('loading members');

    //convert conatacts in home to chatTileData and pass it to allMembers
    final int id = HiveCash.read(boxName: "register_info", key: "id");
    List<chatTileData> members = convertChatModelToChatTileData(
        sl<HomeCubit>().state.contacts, id.toString());

    nameController.clear();
    emit(AddMembersState(
      groupName: '',
      selectedMembers: [],
      state: GroupStatus.initial,
      errorMessage: '',
      allMembers: members,
    ));
  }

  List<chatTileData> convertChatModelToChatTileData(
      List<ChatModel> chats, String currentUserId) {
    return chats.map((chat) {
      final participant = chat.participants.first.userId == currentUserId
          ? chat.participants.last
          : chat.participants.first;

      return chatTileData(
        id: int.parse(participant.userId),
        name: participant.name,
        imageUrl: "", // Assuming imageUrl is not available in ChatModel
        lastSeen: participant.lastSeen,
      );
    }).toList();
  }

  void toggleMember(chatTileData member) {
    print('toggling member');
    final selectedMembers = List<chatTileData>.from(state.selectedMembers);

    if (selectedMembers.contains(member)) {
      selectedMembers.remove(member);
    } else {
      selectedMembers.add(member);
    }

    emit(state.copyWith(
        selectedMembers: selectedMembers, state: GroupStatus.initial));
  }

  void setGroupName(String groupName) {
    emit(state.copyWith(groupName: nameController.text.trim()));
  }

  Future<void> selectGroupImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        emit(state.copyWith(
            groupImageUrl: pickedFile.path, state: GroupStatus.initial));
      }
    } catch (e) {
      emit(state.copyWith(
          errorMessage: 'Failed to select image: $e',
          state: GroupStatus.failure));
    }
  }

  Future<void> createGroup() async {
    try {
      emit(state.copyWith(state: GroupStatus.loadinginfo));

      bool isConnected = await networkManager.isConnected();
      if (!isConnected) {
        emit(state.copyWith(
            errorMessage: 'No internet connection',
            state: GroupStatus.failure));
        return;
      }
      print('creating group');

      final group = GroupsModel(
        id: 0,
        name: nameController.text.trim(),
        imageUrl: state.groupImageUrl ?? '',
        groupSize: 100,
        privacy: true,
      );
      print(group.toJson());
      print('group going');

      final GroupsModel? result = await createGroupUseCase(group);
      print(result);

      if (result != null) {
        print('group created');
        if (state.selectedMembers.isEmpty) {
          emit(state.copyWith(state: GroupStatus.success, group: result));
          return;
        }
        await addMembersUseCase(
          result.id,
          state.selectedMembers
              .map((e) => MemberModel(
                    userId: e.id,
                  ))
              .toList(),
        );
        print('members added');
        emit(state.copyWith(state: GroupStatus.success, group: result));
      } else {
        emit(state.copyWith(
            errorMessage: 'Failed to create group',
            state: GroupStatus.failure));
      }
    } catch (e) {
      print(e.toString());
      emit(state.copyWith(
          errorMessage: e.toString(), state: GroupStatus.failure));
    }
  }
}
