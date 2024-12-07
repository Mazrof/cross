import 'package:telegram/feature/groups/add_new_group/data/model/member_model.dart';
import 'package:telegram/feature/groups/group_setting/domain/repository/group_setting_repository.dart';

class UpdateMemberRoleUseCase {
  final GroupSettingRepository _groupRepository;

  UpdateMemberRoleUseCase(this._groupRepository);
  Future<void> call(int groupId, MemberModel member) async {
    return _groupRepository.updateMemberRole(groupId, member);
  }
}
