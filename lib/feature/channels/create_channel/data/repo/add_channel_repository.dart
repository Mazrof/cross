import 'package:telegram/feature/channels/create_channel/data/data_source/add_channel_data_source.dart';
import 'package:telegram/feature/channels/create_channel/data/model/channel_model.dart';
import 'package:telegram/feature/channels/create_channel/data/model/subscriber_model.dart';
import 'package:telegram/feature/channels/create_channel/domain/repository/add_channel_repo.dart';

class ChannelRepositoryImpl implements ChannelRepository {
  final ChannelRemoteDataSource remoteDataSource;

  ChannelRepositoryImpl(this.remoteDataSource);

  @override
  Future<ChannelModel> createChannel(ChannelModel channel) async {
    return await remoteDataSource.createChannel(channel);
  }

  @override
  Future<void> addSubscribers(
      int channelId, List<SubscriberModel> subscribers) async {
    await remoteDataSource.addSubscribers(channelId, subscribers);
  }
}
