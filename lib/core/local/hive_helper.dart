import 'package:hive_flutter/hive_flutter.dart';
import 'package:telegram/core/local/dp/dashboard/group_model.dart';
import 'package:telegram/core/local/dp/dashboard/user_model.dart';

class HiveHelper {
  static Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(
      UserModelAdapter(),
    );
    Hive.registerAdapter(
      GroupModelAdapter(),
    );

  }

  static Future<void> openBox<T>(String boxName) async {
    if (!Hive.isBoxOpen(boxName)) {
      await Hive.openBox<T>(boxName);
    }
  }

  static Future<void> write<T>(
      {required String boxName, required String key, required T value}) async {
    final box = Hive.box<T>(boxName);
    await box.put(key, value);
  }

  static T? read<T>({required String boxName, required String key}) {
    final box = Hive.box<T>(boxName);
    return box.get(key);
  }

  static Future<void> delete(
      {required String boxName, required String key}) async {
    final box = Hive.box(boxName);
    await box.delete(key);
  }

  static Future<void> clear(String boxName) async {
    final box = Hive.box(boxName);
    await box.clear();
  }

  static List<T> getAll<T>(String boxName) {
    final box = Hive.box<T>(boxName);
    return box.values.toList();
  }


  static Future<void> closeBox(String boxName) async {
    await Hive.box(boxName).close();
  }
}
