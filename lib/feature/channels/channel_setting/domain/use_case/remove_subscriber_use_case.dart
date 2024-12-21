import 'package:telegram/feature/channels/channel_setting/domain/repo/channel_repo.dart';

class RemoveSubscriberUseCase {
  final ChannelSettingRepository repository;

  RemoveSubscriberUseCase(this.repository);

  Future<void> call(int channelId, int memberId) {
    return repository.removeMember(channelId, memberId);
  }
}
