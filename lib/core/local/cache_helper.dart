import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:telegram/core/utililes/app_strings/app_strings.dart';

class CacheHelper {
  static FlutterSecureStorage? securedStorage;

  static AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  static IOSOptions _getIOSOptions() => const IOSOptions();

  static WebOptions _getWebOptions() => WebOptions.defaultOptions;

  static void init() {
    securedStorage = const FlutterSecureStorage();
    // resetRegisterInfo();
  }

  static Future<String?> read({required String key}) async {
    log('Reading key: $key');
    final value = await securedStorage!.read(
      key: key,
      aOptions: _getAndroidOptions(),
      iOptions: _getIOSOptions(),

    );
    log('Read value: $value');
    return value;
  }

  static Future<void> write(
      {required String key, required dynamic value}) async {
    log('Writing key: $key, value: $value');
  
    await securedStorage!.write(
      key: key,
      value: value,
      aOptions: _getAndroidOptions(),
      iOptions: _getIOSOptions(),

    );
  }

  static Future<void> delete({required String key}) async {
    log('Deleting key: $key');
    await securedStorage!.delete(
      key: key,
      aOptions: _getAndroidOptions(),
      iOptions: _getIOSOptions(),

    );
  }

  static Future<void> deleteDate(String key) async {
    log('Deleting data');
    await delete(key: key);
  }

  static Future<void> deleteAllCache() async {
    log('Deleting all cache');
    
    await securedStorage!.deleteAll(
      aOptions: _getAndroidOptions(),
      iOptions: _getIOSOptions(),
      webOptions: _getWebOptions(),
    );
  }
}
