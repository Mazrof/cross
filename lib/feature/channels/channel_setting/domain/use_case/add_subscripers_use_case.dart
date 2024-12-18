import 'package:telegram/feature/channels/channel_setting/domain/repo/channel_repo.dart';
import 'package:telegram/feature/channels/create_channel/data/model/subscriber_model.dart';

class AddSubscribersUseCase {
  final ChannelSettingRepository repository;

  AddSubscribersUseCase(this.repository);

  Future<void> call(int channelId, List<SubscriberModel> subscribers) {
    return repository.addSubscribers(channelId, subscribers);
  }
}
