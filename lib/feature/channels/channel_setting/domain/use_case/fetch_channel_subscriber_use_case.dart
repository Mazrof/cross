import 'package:telegram/feature/channels/channel_setting/data/model/membership_channel_model.dart';
import 'package:telegram/feature/channels/channel_setting/domain/repo/channel_repo.dart';

class FetchChannelSubscriberUseCase {
  final ChannelSettingRepository repository;

  FetchChannelSubscriberUseCase(this.repository);

  Future<List<MembershipChannelModel>> call(int channelId) {
    return repository.fetchChannelMembers(channelId);
  }
}
