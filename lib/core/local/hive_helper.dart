import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:telegram/core/local/dp/dashboard/group_model.dart';
import 'package:telegram/core/local/dp/dashboard/user_model.dart';

class HiveHelper {
  /// Initialize Hive and register adapters
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(GroupModelAdapter());
  }

  /// Open or get an already open box
  static Future<Box<T>> openBox<T>(String boxName) async {
    if (Hive.isBoxOpen(boxName)) {
      return Hive.box<T>(boxName); // Return the already opened box
    } else {
      return await Hive.openBox<T>(boxName); // Open and return the box
    }
  }

  /// Write data to a box
  static Future<void> write<T>(
      {required String boxName, required String key, required T value}) async {
    final box = await openBox<T>(boxName);
    await box.put(key, value);
    closeBox(boxName);
  }

  /// Read data from a box
  static Future<T?> read<T>({required String boxName, required String key}) async {
    final box = await openBox<T>(boxName);
    return box.get(key);
  }

  /// Delete data from a box
  static Future<void> delete(
      {required String boxName, required String key}) async {
    final box = await openBox(boxName);
    await box.delete(key);
    
  }

  /// Clear all data in a box
  static Future<void> clear(String boxName) async {
    final box = await openBox(boxName);
    await box.clear();
  }

  /// Get all values from a box
  static Future<List<T>> getAll<T>(String boxName) async{
   
   final box = await openBox<T>(boxName);
    List<T> list = box.values.toList();
    closeBox(boxName);
    return list;
  }

  /// Close a specific box
  static Future<void> closeBox(String boxName) async {
    if (Hive.isBoxOpen(boxName)) {
      await Hive.box(boxName).close();
    }
  }
}
