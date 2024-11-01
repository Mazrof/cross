abstract class SplashState {}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashFirstTime extends SplashState {}

class SplashAuthenticated extends SplashState {}

class SplashUnauthenticated extends SplashState {}

class SplashEmailVerificationRequired extends SplashState {}

class AnimationInProgress extends SplashState {}

class AnimationMoved extends SplashState {}

class AnimationEnded extends SplashState {}

class TypewriterEffectInProgress extends SplashState {
  final String displayedText;
  final int textIndex;

  TypewriterEffectInProgress(this.displayedText, this.textIndex);
}

class TypewriterEffectCompleted extends SplashState {}
