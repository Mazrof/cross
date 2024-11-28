import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class HiveCash {
  static Future<void> init() async {
    await Hive.initFlutter();
    HiveCash.openBox("register_info");
  }

  static Future<void> openBox(String boxName) async {
    await Hive.openBox(boxName);
  }

  static Future<void> write<T>(
      {required String boxName, required String key, required T value}) async {
    final box = Hive.box(boxName);
    await box.put(key, value);
  }

  static T? read<T>({required String boxName, required String key}) {
    final box = Hive.box(boxName);
    return box.get(key);
  }

  static Future<void> delete(
      {required String boxName, required String key}) async {
    final box = Hive.box(boxName);
    await box.delete(key);
  }

  static readAll<T>({required String boxName}) {
    final box = Hive.box(boxName);
    return box.values;
  }

  static Future<void> clear(String boxName) async {
    final box = Hive.box(boxName);
    await box.clear();
  }
}
