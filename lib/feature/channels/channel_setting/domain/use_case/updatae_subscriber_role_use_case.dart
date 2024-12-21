import 'package:telegram/feature/channels/channel_setting/data/model/membership_channel_model.dart';
import 'package:telegram/feature/channels/channel_setting/domain/repo/channel_repo.dart';

class UpdateSubscriberRoleUseCase {
  final ChannelSettingRepository repository;

  UpdateSubscriberRoleUseCase(this.repository);

  Future<void> call(int channelId, MembershipChannelModel member) {
    return repository.updateMemberRole(channelId, member);
  }
}
