
import 'package:telegram/feature/groups/group_setting/data/model/membership_model.dart';
import 'package:telegram/feature/groups/group_setting/domain/repository/group_setting_repository.dart';

class FetchGroupMembersUseCase {
  final GroupSettingRepository _groupRepository;

  FetchGroupMembersUseCase(this._groupRepository);

  Future<List<MembershipModel>> execute(int groupId) async {
    return _groupRepository.fetchMembers(groupId);
  }
}
