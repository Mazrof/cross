import 'package:telegram/feature/channels/channel_setting/domain/repo/channel_repo.dart';

class DeleteChannelUseCase {
  final ChannelSettingRepository repository;

  DeleteChannelUseCase(this.repository);

  Future<void> call(int channelId) {
    return repository.deleteChannel(channelId);
  }
}
