

import 'package:telegram/feature/home/data/model/chat_model.dart';
import 'package:telegram/feature/home/domain/repo/home_repo.dart';

class FetchContactsUseCase {
  final HomeRepository repository;

  FetchContactsUseCase({required this.repository});

  Future<List<ChatModel>> call() async {
    return await repository.fetchContacts();
  }
}
