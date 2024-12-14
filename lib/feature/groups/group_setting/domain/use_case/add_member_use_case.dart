import 'package:telegram/feature/groups/add_new_group/data/model/member_model.dart';
import 'package:telegram/feature/groups/group_setting/domain/repository/group_setting_repository.dart';

class AddMemberUseCase {
  final GroupSettingRepository _groupRepository;

  AddMemberUseCase(this._groupRepository);

  Future<void> call(int groupId, List<MemberModel> userIds) async {
    return _groupRepository.addMember(groupId, userIds);
  }
}
