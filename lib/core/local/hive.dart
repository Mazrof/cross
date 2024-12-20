import 'package:hive_flutter/adapters.dart';

class HiveCash {
  static Future<void> init() async {
    await Hive.initFlutter();
    await Future.wait([
      openBox("register_info"),
      openBox("channels"),
      openBox("stories"),
      openBox("groups"),
      openBox("contacts"),
      openBox("groups_dash"),
      openBox("users_dash"),
    ]);
  }

  static Future<void> openBox(String boxName) async {
    if (!Hive.isBoxOpen(boxName)) {
      await Hive.openBox(boxName); // Open the box only if it's not already open
    }
  }

  static Future<void> write<T>({
    required String boxName,
    required String key,
    required T value,
  }) async {
    final box =
        await Hive.openBox(boxName); // Ensure the box is opened before writing
    await box.put(key, value);
  }

  static T? read<T>({
    required String boxName,
    required String key,
  }) {
    final box = Hive.box(
        boxName); // Directly accessing the box, assuming it's already open
    return box.get(key);
  }

  static Future<void> delete({
    required String boxName,
    required String key,
  }) async {
    final box = Hive.box(boxName);
    await box.delete(key);
  }

  static readAll<T>({
    required String boxName,
  }) {
    final box = Hive.box(boxName);
    return box.values;
  }

  static Future<void> clear(String boxName) async {
    final box = Hive.box(boxName);
    await box.clear();
  }

  static Future<void> deleteAllBoxes() async {
    await Hive.deleteFromDisk();
  }
}
