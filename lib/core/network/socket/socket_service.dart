import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/local/hive.dart';
import 'package:telegram/core/utililes/app_strings/app_strings.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:telegram/feature/messaging/presentation/controller/chat_bloc.dart';
import 'package:telegram/feature/messaging/presentation/controller/chat_state.dart';

class SocketService {
  static const String server = AppStrings.socketUrl;

  IO.Socket? socket;

  SocketService();

  void setUpListeners() {
    socket!.on('connect', (_) {
      print('Connected to server');
    });

    socket!.on('message:receive', (data) {
      print(data);
      sl<ChatCubit>().receiveMessage(data);
    });

    socket!.on('message:edited', (data) {
      print("Message Edited!");

      sl<ChatCubit>().messageEdited(data);
    });

    socket!.on('message:deleted', (data) {
      print("Message Deleted!");

      sl<ChatCubit>().messageDeleted(data);
    });

    socket!.on(
      'disconnect',
      (_) {
        print('Disconnected from server');
      },
    );
  }

  void connect() async {
    try {
      // hard coded
      int myId = HiveCash.read(boxName: 'register_info', key: 'id');
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/my_file.txt');

      String cookie = await file.readAsString();

      cookie = cookie.substring(1, cookie.length - 1);

      socket = IO.io(
        'http://10.0.2.2:3000',
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .setExtraHeaders(
              {'cookie': cookie},
            )
            .disableAutoConnect()
            .build(),
      );

      socket = socket!.connect();

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

           // "connect.sid=s%3AjiBDjpx1VZq2QEuFm7e3eyurc5Py_2IB.UGGHk1l5hCO%2F%2FK6%2B4oHI7LM2Ib4nrJrFxw9fqDR4BSY; Expires=Sat, 07 Dec 2024 13:08:04 GMT; Path=/; HttpOnly";
