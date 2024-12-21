import 'package:telegram/feature/channels/channel_setting/domain/repo/channel_repo.dart';
import 'package:telegram/feature/channels/create_channel/data/model/channel_model.dart';

class UpdateChannelDetailsUseCase {
  final ChannelSettingRepository repository;

  UpdateChannelDetailsUseCase(this.repository);

  Future<void> call(int channelId, ChannelModel channel) {
    return repository.updateChannelDetails(channelId, channel);
  }
}
