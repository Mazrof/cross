
import 'package:telegram/feature/channels/create_channel/data/model/subscriber_model.dart';
import 'package:telegram/feature/channels/create_channel/domain/repository/add_channel_repo.dart';

class AddSubscribersUseCase {
  final ChannelRepository repository;

  AddSubscribersUseCase(this.repository);

  Future<void> call(int channelId, List<SubscriberModel> subscribers) async {
    await repository.addSubscribers(channelId, subscribers);
  }
}
