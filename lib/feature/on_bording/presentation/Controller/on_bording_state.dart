import 'package:flutter/material.dart';
import 'package:telegram/feature/on_bording/data/models/on_bording_model.dart';

class OnBordingState {
  final int currentPage;
  final PageController controller;
  final List<OnboardingContents> onBordingcontents;


  OnBordingState({
    required this.currentPage,
    required this.controller,
    required this.onBordingcontents,
  });

  OnBordingState copyWith({
    int? currentPage,
    PageController? controller,
    List<Color>? colors,
    List<OnboardingContents>? onBordingcontents,
  }) {
    return OnBordingState(
      currentPage: currentPage ?? this.currentPage,
      controller: controller ?? this.controller,
      onBordingcontents: onBordingcontents ?? this.onBordingcontents,
    );
  }
}
