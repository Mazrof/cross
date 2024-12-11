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
          state: CubitState.initial,
          errorMessage: '',
        ));

  final NetworkManager networkManager;
  final CreateGroupUseCase createGroupUseCase;
  final AddMembersUseCase addMembersUseCase;
  final ImagePicker _picker = ImagePicker();
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  void loadMembers() {
    List<ChatModel> members = sl<HomeCubit>().state.chats;
    nameController.clear();
    emit(AddMembersState(
      groupName: '',
      selectedMembers: [],
      state: CubitState.initial,
      errorMessage: '',
      allMembers: members,
    ));
  }

  void toggleMember(ChatModel member) {
    final selectedMembers = List<ChatModel>.from(state.selectedMembers);

    if (selectedMembers.contains(member)) {
      selectedMembers.remove(member);
    } else {
      selectedMembers.add(member);
    }

    emit(state.copyWith(
        selectedMembers: selectedMembers, state: CubitState.initial));
  }

  void setGroupName(String groupName) {
    emit(state.copyWith(groupName: nameController.text.trim()));
  }

  Future<void> selectGroupImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        emit(state.copyWith(
            groupImageUrl: pickedFile.path, state: CubitState.initial));
      }
    } catch (e) {
      emit(state.copyWith(
          errorMessage: 'Failed to select image: $e',
          state: CubitState.failure));
    }
  }

  Future<void> createGroup() async {
    try {
      emit(state.copyWith(state: CubitState.loading));

      bool isConnected = await networkManager.isConnected();
      if (!isConnected) {
        emit(state.copyWith(
            errorMessage: 'No internet connection', state: CubitState.failure));
        return;
      }

      final group = GroupsModel(
        id: 0,
        name: nameController.text.trim(),
        imageUrl: state.groupImageUrl ?? '',
        groupSize: 100,
        privacy: true,
        admins:
        HiveCash.read(boxName: "register_info", key: 'id')
      

      );
      print(group.toJson());

      final GroupsModel? result = await createGroupUseCase(group);
      print(result);

      if (result != null) {
        // await addMembersUseCase(
        //   result.id,
        //   state.selectedMembers.map((e) => MemberModel(userId: e.id)).toList(),
        // );
        emit(state.copyWith(state: CubitState.success, group: result));
      } else {
        emit(state.copyWith(
            errorMessage: 'Failed to create group', state: CubitState.failure));
      }
    } catch (e) {
      print(e.toString());
      emit(state.copyWith(
          errorMessage: e.toString(), state: CubitState.failure));
    }
  }
}
