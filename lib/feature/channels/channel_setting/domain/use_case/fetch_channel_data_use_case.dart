import 'package:telegram/feature/channels/channel_setting/domain/repo/channel_repo.dart';
import 'package:telegram/feature/channels/create_channel/data/model/channel_model.dart';

class FetchChannelDetailsUseCase {
  final ChannelSettingRepository repository;

  FetchChannelDetailsUseCase(this.repository);

  Future<ChannelModel> call(int channelId) {
    return repository.fetchChannelDetails(channelId);
  }
}
