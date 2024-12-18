

import 'package:telegram/core/local/dp/dashboard/group_model.dart';
import 'package:telegram/feature/home/domain/repo/home_repo.dart';

class FetchGroupsUseCase {
  final HomeRepository repository;

  FetchGroupsUseCase({required this.repository});

  Future<List<GroupModel>> call() async {
    return await repository.fetchGroups();
  }
}
