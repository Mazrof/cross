import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/local/hive.dart';
import 'package:telegram/core/network/network_manager.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/channels/create_channel/data/model/channel_model.dart';
import 'package:telegram/feature/channels/create_channel/data/model/subscriber_model.dart';
import 'package:telegram/feature/channels/create_channel/domain/use_case/add_subscribers_use_case.dart';
import 'package:telegram/feature/channels/create_channel/domain/use_case/creat_channel_use_case.dart';
import 'package:telegram/feature/channels/create_channel/presentatin/controller/add_channel_state.dart';
import 'package:telegram/feature/groups/add_new_group/domain/entity/chat_tile_data.dart';
import 'package:telegram/feature/home/data/model/chat_model.dart';
import 'package:telegram/feature/home/presentation/controller/home/home_cubit.dart';
import 'package:image_picker/image_picker.dart';

class AddChannelCubit extends Cubit<AddChannelState> {
  AddChannelCubit(
    this.createChannelUseCase,
    this.networkManager,
    this.addSubscribersUseCase,
  ) : super(AddChannelState.initial());

  final NetworkManager networkManager;
  final CreateChannelUseCase createChannelUseCase;
  final AddSubscribersUseCase addSubscribersUseCase;
  final ImagePicker _picker = ImagePicker();
  final nameController = TextEditingController();

  void loadSubscribers() {
    AddChannelState.initial();
    List<ChatModel> members = sl<HomeCubit>().state.contacts;
    List<chatTileData> sub = members.map((chat) {
      return chatTileData(
        id: chat.id,
        name: chat.secondUser.username,
        imageUrl: chat.secondUser.photo ?? '',
        lastSeen: chat.secondUser.lastSeen.toString(),
      );
    }).toList();

    emit(state.copyWith(allSubscribers: sub));
  }

  void toggleSubscriber(chatTileData subscriber) {
    final selectedSubscribers =
        List<chatTileData>.from(state.selectedSubscribers);

    if (selectedSubscribers.contains(subscriber)) {
      selectedSubscribers.remove(subscriber);
    } else {
      selectedSubscribers.add(subscriber);
    }

    emit(state.copyWith(selectedSubscribers: selectedSubscribers));
  }

  Future<void> selectChannelImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        emit(state.copyWith(
            channelImageUrl: pickedFile.path, state: CubitState.initial));
      }
    } catch (e) {
      emit(state.copyWith(
          errorMessage: 'Failed to select image: $e',
          state: CubitState.failure));
    }
  }

  void setChannelName(String name) {
    emit(state.copyWith(channelName: name));
  }

  void setChannelPrivacy(bool isPublic) {
    emit(state.copyWith(
        privacy: isPublic ? true : false, state: CubitState.initial));
  }

  Future<void> createChannel() async {
    try {
      emit(state.copyWith(state: CubitState.loading));
      print('Creating channel...');

      bool isConnected = await networkManager.isConnected();
      print('Network connected: $isConnected');

      if (!isConnected) {
        emit(state.copyWith(
            errorMessage: 'No internet connection', state: CubitState.failure));
        return;
      }

      final channel = ChannelModel(
        id: 0,
        name: state.channelName,
        imageUrl: state.channelImageUrl ?? '',
        privacy: state.privacy,
        canAddComments: true,
      );
      print('Channel: $channel');

      final ChannelModel? result = await createChannelUseCase(channel);
      print('Channel created: $result');

      if (result != null) {
        await addSubscribersUseCase(
          result.id,
          state.selectedSubscribers
              .map((e) => SubscriberModel(
                    userId: e.id,
                    role: "member",
                    channelId: result.id,
                    hasDownloadPermissions: true,
                  ))
              .toList(),
        );
        emit(state.copyWith(state: CubitState.success, channel: result));
        print('Channel creation successful');
      } else {
        emit(state.copyWith(
            errorMessage: 'Failed to create channel',
            state: CubitState.failure));
        print('Channel creation failed');
      }
    } catch (e) {
      emit(state.copyWith(
          errorMessage: e.toString(), state: CubitState.failure));
      print('Error creating channel: $e');
    }
  }
}
