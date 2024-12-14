import 'package:telegram/feature/groups/group_setting/domain/repository/group_setting_repository.dart';

class MuteUseCase {
  final GroupSettingRepository _groupRepository;

  MuteUseCase(this._groupRepository);

  Future<void> call(int groupId, bool mute) async {
    _groupRepository.muteToggle(groupId, mute);
  }
}
