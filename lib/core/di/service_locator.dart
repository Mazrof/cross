import 'package:get_it/get_it.dart';
import 'package:telegram/core/local/cache_helper.dart';
import 'package:telegram/core/network/api/api_service.dart';

final sl = GetIt.instance;

class ServiceLocator {
  static void init() {
    CacheHelper.init();
    registerSingletons();
    registerDataSources();
    registerRepositories();
    registerUseCases();
    registerCubits();
    registerCore();
  }

  static void registerCubits() {}
  static void registerUseCases() {}

  static void registerRepositories() {

  }

  static void registerDataSources() {


  }

  static void registerCore() {

  }

  static void registerSingletons() {
    sl.registerSingleton<ApiService>(ApiService());

  }
}
