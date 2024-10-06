import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  Stream<bool> get onConnectionChanged;
  Future<void> checkInternet();
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker connectionChecker;

  NetworkInfoImpl({required this.connectionChecker});

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;

  @override
  Stream<bool> get onConnectionChanged =>
      connectionChecker.onStatusChange.map((status) {
        return status == InternetConnectionStatus.connected;
      });

  @override
  Future<void> checkInternet() async {
    await connectionChecker.hasConnection;
  }
}
