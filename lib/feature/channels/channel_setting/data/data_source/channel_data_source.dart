import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/network/api/api_service.dart';
import 'package:telegram/feature/channels/create_channel/data/model/channel_model.dart';
import 'package:telegram/feature/channels/create_channel/data/model/subscriber_model.dart';
import 'package:telegram/feature/channels/channel_setting/data/model/membership_channel_model.dart';

abstract class ChannelSettingRemoteDataSource {
  Future<void> addSubscribers(int channelId, List<SubscriberModel> subscribers);
  Future<ChannelModel> fetchChannelDetails(int channelId);
  Future<List<MembershipChannelModel>> fetchChannelMembers(int channelId);
  Future<void> updateMemberRole(int channelId, MembershipChannelModel member);
  Future<void> removeMember(int channelId, int memberId);
  Future<void> deleteChannel(int channelId);
  Future<void> updateChannelDetails(int channelId, ChannelModel channel);
}

class ChannelSettingRemoteDataSourceImpl
    extends ChannelSettingRemoteDataSource {
  final ApiService apiService = sl<ApiService>();

  ChannelSettingRemoteDataSourceImpl();

  @override
  Future<ChannelModel> fetchChannelDetails(int channelId) async {
    print(channelId);
    print('fetchChannelDetails');

    print('i am here here here ');

    final response = await apiService.get(
      endPoint: 'channels/$channelId',
    );
    print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh" + response.data);
    print(ChannelModel.fromJson(response.data['data']['channel']));
    return ChannelModel.fromJson(response.data['data']['channel']);
  }

  @override
  Future<List<MembershipChannelModel>> fetchChannelMembers(
      int channelId) async {
    print('iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii');
    final response = await apiService.get(
      endPoint: 'channels/$channelId/members',
    );
    print(response.data);
    print('in the memvers ');
    print('here in the subscripers ');
    return (response.data['data'] as List)
        .map((json) => MembershipChannelModel.fromJson(json))
        .toList();
  }

  @override
  Future<void> updateMemberRole(
      int channelId, MembershipChannelModel member) async {
    await apiService.patch(
      endPoint: 'channels/$channelId/members/${member.userId}',
      data: {
        'role': member.role,
        'hasDownloadPermissions': member.hasDownloadPermissions,
      },
    );
  }

  @override
  Future<void> removeMember(int channelId, int memberId) async {
    await apiService.delete(
      endPoint: 'channels/$channelId/members/$memberId',
    );
  }

  @override
  Future<void> deleteChannel(int channelId) async {
    await apiService.delete(
      endPoint: 'channels/$channelId',
    );
  }

  @override
  Future<void> updateChannelDetails(int channelId, ChannelModel channel) async {
    await apiService.patch(
      endPoint: 'channels/$channelId',
      data: channel.toJson(),
    );
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
