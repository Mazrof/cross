import 'package:telegram/core/network/api/api_constants.dart';
import 'package:telegram/core/network/api/api_service.dart';
import 'package:telegram/feature/search/data/models/global_search_model.dart';

import 'package:http/http.dart' as http;

abstract class GlobalSearchDataSource {
  Future<GlobalSearchModel> searchGlobal(String searchQuery);
}

class GlobalSearchRemoteDataSource extends GlobalSearchDataSource {
  final ApiService _apiService;

  GlobalSearchRemoteDataSource({
    required ApiService apiService,
  }) : _apiService = apiService;

  @override
  Future<GlobalSearchModel> searchGlobal(String searchQuery) async {
    try {
      final response = await _apiService.get(
          endPoint: ApiConstants.globalSearchQuery,
          queryParameters: {"query": searchQuery});
      if (response.statusCode == 200 || response.statusCode == 201) {
        return GlobalSearchModel.fromJson(response.data);
      } else {
        throw Exception(
            "Global Search failed with status code ${response.statusCode}");
      }
    } catch (error) {
      print("Failed to search : $error");
      throw Exception("Global Search Failed");
    }
  }
}
