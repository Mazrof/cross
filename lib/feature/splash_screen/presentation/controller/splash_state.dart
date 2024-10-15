
import 'package:equatable/equatable.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

class SplashInitial extends SplashState {}

class AnimationInProgress extends SplashState {}

class AnimationMoved extends SplashState {}

class AnimationEnded extends SplashState {}

class TypewriterEffectInProgress extends SplashState {
  final String displayedText;
  final int textIndex;

  const TypewriterEffectInProgress(this.displayedText, this.textIndex);

  @override
  List<Object> get props => [displayedText, textIndex];
}

class TypewriterEffectCompleted extends SplashState {}

class SplashLoading extends SplashState {}

class SplashAuthenticated extends SplashState {}

class SplashUnauthenticated extends SplashState {}

class SplashFirstTime extends SplashState {}