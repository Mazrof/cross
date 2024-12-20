

import 'package:telegram/core/local/dp/dashboard/group_model.dart';
import 'package:telegram/feature/home/data/model/group_data_model.dart';
import 'package:telegram/feature/home/domain/repo/home_repo.dart';

class FetchGroupsUseCase {
  final HomeRepository repository;

  FetchGroupsUseCase({required this.repository});

  Future<List<GroupDataModel>> call() async {
    return await repository.fetchGroups();
  }
}
