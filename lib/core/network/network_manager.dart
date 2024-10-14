import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

class NetworkManager {
  // StreamController for connection status
  final _connectionStatusController = StreamController<ConnectivityResult>.broadcast();
  Stream<ConnectivityResult> get connectionStatusStream => _connectionStatusController.stream;

  // Connectivity instance
  final Connectivity _connectivity = Connectivity();
 var connectionStatus = ConnectivityResult.none;


  // Subscription to connectivity changes
  late StreamSubscription<List<ConnectivityResult>> connectivitySubscription;
  NetworkManager() {

    // Initialize the connectivity subscription
     connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((results) {
            _updateConnectionStatus(results[0]);
        });
    // Check the initial connectivity status
    _checkInitialConnectivity();
  }

  /// Check the initial connectivity status
  Future<void> _checkInitialConnectivity() async {
    try {
      final result = await _connectivity.checkConnectivity();
      _updateConnectionStatus(result.first);
    } catch (e) {
      print('Error checking initial connectivity: $e');
    }
  }

  /// Update the connection status based on changes in connectivity
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _connectionStatusController.add(result);
  }

  /// Check if the device has actual internet access by making a simple HTTP request.
  Future<bool> _hasInternetAccess() async {
    try {
      final response = await http.get(Uri.parse('https://www.google.com'));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  /// Check if the device is connected to the internet.
  Future<bool> isConnected() async {
    try {
      final result = await _connectivity.checkConnectivity();
      if (result == ConnectivityResult.none) {
        return false;
      } else {
        return await _hasInternetAccess();
      }
    } catch (e) {
      return false;
    }
  }

  /// Dispose the connectivity subscription and stream controller when done.
  void dispose() {
    connectivitySubscription.cancel();
    _connectionStatusController.close();
  }
}