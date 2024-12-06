import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram/core/local/hive.dart';
import 'package:telegram/core/network/network_manager.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/groups/add_new_group/data/model/chat_tile_model.dart';
import 'package:telegram/feature/groups/add_new_group/data/model/groups_model.dart';
import 'package:telegram/feature/groups/add_new_group/data/model/member_model.dart';
import 'package:telegram/feature/groups/add_new_group/domain/entity/chat_tile_data.dart';
import 'package:telegram/feature/groups/add_new_group/domain/use_case/add_members_use_case.dart';
import 'package:telegram/feature/groups/add_new_group/domain/use_case/create_group_use_case.dart';
import 'package:telegram/feature/groups/add_new_group/presentation/controller/add_group_state.dart';

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

  void loadMembers() {
    emit(AddMembersState(
      groupName: '',
      selectedMembers: [],
      state: CubitState.initial,
      errorMessage: '',
    ));

    // Simulate loading members   -> should be replaced with the members data in the home screen call  ->load from home
    Future.delayed(Duration(seconds: 2), () {
      final List<chatTileModel> members = [
        chatTileModel(
          id: 1,
          name: 'John Doe',
          imageUrl: 'https://example.com/john_doe.png',
          lastSeen: 'last seen at 4:29 PM',
        ),
        chatTileModel(
          id: 2,
          name: 'Jane Smith',
          imageUrl: 'https://example.com/jane_smith.png',
          lastSeen: 'last seen at 10:00 AM',
        ),
      ];

      emit(state.copyWith(state: CubitState.success, allMembers: members));
    });
  }

  void toggleMember(chatTileModel member) {
    final selectedMembers = List<chatTileModel>.from(state.selectedMembers);

    if (selectedMembers.contains(member)) {
      selectedMembers.remove(member);
    } else {
      selectedMembers.add(member);
    }

    emit(state.copyWith(selectedMembers: selectedMembers));
  }

  void setGroupName(String name) {
    emit(state.copyWith(groupName: name));
  }

  Future<void> createGroup() async {
    try {
      emit(state.copyWith(state: CubitState.loading));

      bool isConnected = await networkManager.isConnected();

      if (!isConnected) {
        emit(state.copyWith(errorMessage: 'No internet connection'));
        return;
      }

      final group = GroupsModel(
          id: 0,
          name: state.groupName,
          imageUrl: state.groupImageUrl ?? '',
          groupSize: 1,
          privacy: true,
          admins: [
            HiveCash.read(boxName: 'register_info', key: 'id'),
          ]);

      final result = await createGroupUseCase(group);

      if (result != null) {
        await addMembersUseCase(
            result.id,
            state.selectedMembers
                .map((e) => MemberModel(userId: e.id))
                .toList());

        emit(state.copyWith(state: CubitState.success));
      } else {
        emit(state.copyWith(errorMessage: 'Failed to create group'));
      }
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  void setGroupImageUrl(String imageUrl) {
    emit(state.copyWith(groupImageUrl: imageUrl));
  }
}
