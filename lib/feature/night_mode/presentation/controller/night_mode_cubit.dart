import 'package:bloc/bloc.dart';

class NightModeCubit extends Cubit<bool> {
  NightModeCubit({required bool initialState}) : super(initialState);

  void toggleNightMode() => emit(!state);

  void setNightMode(bool isNightMode) => emit(isNightMode);
}