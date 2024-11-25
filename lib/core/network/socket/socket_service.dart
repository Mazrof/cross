import 'dart:io';

import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/utililes/app_strings/app_strings.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:telegram/feature/messaging/presentation/controller/chat_bloc.dart';
import 'package:telegram/feature/messaging/presentation/controller/chat_state.dart';

class SocketService {
  static const String server = AppStrings.socketUrl;

  IO.Socket socket;

  SocketService()
      : socket = IO.io(
          'http://10.0.2.2:3000',
          IO.OptionBuilder()
              .setTransports(['websocket'])
              .disableAutoConnect()
              .build(),
        ) {}

  void setUpListeners() {
    socket.on('connect', (_) {
      print('Connected to server');
    });

    socket.on('message:receive', (data) {
      print(data);
      sl<ChatCubit>().receiveMessage(data);
    });

    socket.on(
      'disconnect',
      (_) {
        print('Disconnected from server');
      },
    );
  }

  void connect() async {
    try {
      socket = socket.connect();

      setUpListeners();
    } catch (e) {
      print(e);

      // if (e is DioException) {
      //   throw ServerFailure.fromDioError(e);
      // } else {
      //   log("i will call handle error in api service");
      //   throw _handleError(e);
      // }
    }
  }
}
