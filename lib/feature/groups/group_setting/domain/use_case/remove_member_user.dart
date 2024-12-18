import 'package:telegram/feature/groups/group_setting/domain/repository/group_setting_repository.dart';

class RemoveMemberUseCase {
  final GroupSettingRepository _groupRepository;

  RemoveMemberUseCase(this._groupRepository);

  Future<void> call(int groupId, int memberId) async {
    return _groupRepository.removeMember(groupId, memberId);
  }
}
