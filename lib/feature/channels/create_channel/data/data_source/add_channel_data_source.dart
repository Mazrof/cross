import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/network/api/api_service.dart';
import 'package:telegram/feature/channels/create_channel/data/model/channel_model.dart';
import 'package:telegram/feature/channels/create_channel/data/model/subscriber_model.dart';

abstract class ChannelRemoteDataSource {
  Future<ChannelModel> createChannel(ChannelModel channel);
  Future<void> addSubscribers(int channelId, List<SubscriberModel> subscribers);
}

class ChannelRemoteDataSourceImpl implements ChannelRemoteDataSource {
  final ApiService apiService = sl<ApiService>();

  ChannelRemoteDataSourceImpl();

  @override
  Future<ChannelModel> createChannel(ChannelModel channel) async {
    print(channel.toJson());
    final response = await apiService.post(
      endPoint: 'channels',
      data: channel.toJson(),
    );
    print(response.data);
    return ChannelModel.fromJson(response.data['data']['channel']);
  }

  @override
  Future<void> addSubscribers(
      int channelId, List<SubscriberModel> subscribers) async {
    for (final subscriber in subscribers) {
      await apiService.post(
        endPoint: 'channels/$channelId/members',
        data: {
          'userId': subscriber.userId,
          'role': subscriber.role,
          'hasDownloadPermissions': subscriber.hasDownloadPermissions,
        },
      );
    }
  }
}
