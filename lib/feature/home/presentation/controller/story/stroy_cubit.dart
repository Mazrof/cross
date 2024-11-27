import 'dart:async';

import 'package:bloc/bloc.dart';

class StoryViewerCubit extends Cubit<double> {
  late bool _isHolding;
  late int _timerMilliseconds;

  StoryViewerCubit()
      : _isHolding = false,
        _timerMilliseconds = 100,
        super(0.0) {
    _startProgress();
  }

  void _startProgress() {
    Timer.periodic(Duration(milliseconds: _timerMilliseconds), (timer) {
      if (!_isHolding) {
        emit(state + 0.01);
        if (state >= 1.0) {
          timer.cancel();
        }
      }
    });
  }

  void startHolding() {
    _isHolding = true;
  }

  void stopHolding() {
    
    _isHolding = false;
  }
}
