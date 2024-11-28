import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/home/presentation/controller/story/add_stroy_state.dart';

class AddStoryCubit extends Cubit<AddStoryState> {
  AddStoryCubit() : super(AddStoryState());

  final ImagePicker _picker = ImagePicker();

  Future<void> setStory(String image, String caption) async {
    emit(state.copyWith(
        state: CubitState.loading)); // Show loading while picking
    try {
      // sent to back ///TODO: implement the logic to send the story to the backend
      emit(state.copyWith(
          storyPath: image,
          caption: caption,
          state: CubitState.success)); // Successfully picked story
    } catch (e) {
      emit(state.copyWith(state: CubitState.failure)); // Error picking story
    }
  }

  void updateCaption(String caption) {
    emit(state.copyWith(caption: caption)); // Update caption
  }

  void resetStory() {
    emit(AddStoryState()); // Reset the story and caption
  }
}
