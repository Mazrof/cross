import 'package:telegram/feature/groups/add_new_group/data/model/groups_model.dart';
import 'package:telegram/feature/groups/add_new_group/data/model/member_model.dart';

abstract class CreateGroupRepository {
  Future<GroupsModel> createGroup(GroupsModel group);

  Future<void> addMembers(int id, List<MemberModel> members);
}