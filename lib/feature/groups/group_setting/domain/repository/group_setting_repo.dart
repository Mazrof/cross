import 'package:telegram/feature/dashboard/data/model/group_model.dart';

abstract class GroupSettingRepo {

  Future<GroupModel> getGroupSetting(String groupId);

  Future<void> updateGroupSetting(GroupModel groupSetting);
  


}
