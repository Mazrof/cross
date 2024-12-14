
import 'package:telegram/feature/channels/create_channel/data/model/channel_model.dart';
import 'package:telegram/feature/channels/create_channel/data/model/subscriber_model.dart';

abstract class ChannelRepository {
  Future<ChannelModel> createChannel(ChannelModel channel);
  Future<void> addSubscribers(int channelId, List<SubscriberModel> subscribers);
}
