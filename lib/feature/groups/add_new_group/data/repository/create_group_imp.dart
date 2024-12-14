import 'package:telegram/feature/dashboard/data/model/group_model.dart';
import 'package:telegram/feature/groups/add_new_group/data/data_source/data_source.dart';
import 'package:telegram/feature/groups/add_new_group/data/model/groups_model.dart';
import 'package:telegram/feature/groups/add_new_group/data/model/member_model.dart';
import 'package:telegram/feature/groups/add_new_group/domain/repository/create_group_repo.dart';

class GroupRepositoryImpl implements CreateGroupRepository {
  CreateGroupDataSource remoteDataSource;

  GroupRepositoryImpl(this.remoteDataSource);

  @override
  Future<GroupsModel> createGroup(GroupsModel group) {
    return remoteDataSource.createGroup(group);
  }

  @override
  Future<void> addMembers(int id, List<MemberModel> members) {
    return remoteDataSource.addMembers(id, members);
  }


}
