import 'package:telegram/feature/home/data/model/story_model.dart';
import 'package:telegram/feature/home/domain/repo/home_repo.dart';

class FetchStoriesUseCase {
  final HomeRepository repository;

  FetchStoriesUseCase({required this.repository});

  Future<List<StoryModel>> call() async {
    return await repository.fetchStories();
  }
}
