import 'package:telegram/feature/groups/group_setting/domain/repository/group_setting_repository.dart';

class DeleteGroupUseCase {
  final GroupSettingRepository _groupRepository;

  DeleteGroupUseCase(this._groupRepository);

  Future<void> call(int groupId) async {
    return _groupRepository.deleteGroup(groupId);
  }
}
