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
    print("Channel ID: $channelId");
    print('Fetching channel details...');

    final response = await apiService.get(endPoint: 'channels/$channelId');

    print("Raw response: ${response.data}");

    // Ensure the structure matches your expectation
    final channelData =
        response.data['data']['channel'] as Map<String, dynamic>;
    print("Parsed channel data: $channelData");

    // Parse the channel data into ChannelModel
    final channel = ChannelModel.fromJson(channelData);
    print("ChannelModel: $channel");

    return channel;
  }

@override
  Future<List<MembershipChannelModel>> fetchChannelMembers(
      int channelId) async {
    print('Fetching channel members...');
    final response = await apiService.get(
      endPoint: 'channels/$channelId/members',
    );

    print(response.data); // Log the response to verify structure

    // Extract the 'members' list from 'data'
    final members = response.data['data']['members'] as List<dynamic>;

    // Map each member to a MembershipChannelModel
    return members
        .map((json) =>
            MembershipChannelModel.fromJson(json as Map<String, dynamic>))
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
