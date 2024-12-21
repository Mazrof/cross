import 'package:telegram/feature/channels/channel_setting/data/model/membership_channel_model.dart';
import 'package:telegram/feature/channels/create_channel/data/model/channel_model.dart';
import 'package:telegram/feature/channels/create_channel/data/model/subscriber_model.dart';

abstract class ChannelSettingRepository {
  Future<ChannelModel> fetchChannelDetails(int channelId);
  Future<List<MembershipChannelModel>> fetchChannelMembers(int channelId);
  Future<void> updateMemberRole(int channelId, MembershipChannelModel member);
  Future<void> removeMember(int channelId, int memberId);
  Future<void> deleteChannel(int channelId);
  Future<void> updateChannelDetails(int channelId, ChannelModel channel);
   Future<void> addSubscribers(int channelId, List<SubscriberModel> subscribers);
}
