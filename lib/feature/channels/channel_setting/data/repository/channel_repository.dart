import 'package:flutter/material.dart';
import 'package:telegram/feature/channels/channel_setting/data/data_source/channel_data_source.dart';
import 'package:telegram/feature/channels/channel_setting/data/model/membership_channel_model.dart';
import 'package:telegram/feature/channels/channel_setting/domain/repo/channel_repo.dart';
import 'package:telegram/feature/channels/create_channel/data/model/channel_model.dart';
import 'package:telegram/feature/channels/create_channel/data/model/subscriber_model.dart';

class ChannelSettingRepositoryImpl implements ChannelSettingRepository {
  final ChannelSettingRemoteDataSource remoteDataSource;

  ChannelSettingRepositoryImpl(this.remoteDataSource);

  @override
  Future<ChannelModel> fetchChannelDetails(int channelId) {
    return remoteDataSource.fetchChannelDetails(channelId);
  }

  @override
  Future<List<MembershipChannelModel>> fetchChannelMembers(int channelId) {
    return remoteDataSource.fetchChannelMembers(channelId);
  }

  @override
  Future<void> updateMemberRole(int channelId, MembershipChannelModel member) {
    return remoteDataSource.updateMemberRole(channelId, member);
  }

  @override
  Future<void> removeMember(int channelId, int memberId) {
    return remoteDataSource.removeMember(channelId, memberId);
  }

  @override
  Future<void> deleteChannel(int channelId) {
    return remoteDataSource.deleteChannel(channelId);
  }

  @override
  Future<void> updateChannelDetails(int channelId, ChannelModel channel) {
    return remoteDataSource.updateChannelDetails(channelId, channel);
  }

  @override
  Future<void> addSubscribers(int channelId, List<SubscriberModel> subscribers) {
    return remoteDataSource.addSubscribers(channelId, subscribers);
  }

  
}
