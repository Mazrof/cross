import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram/feature/night_mode/presentation/controller/night_mode_cubit.dart';

class ShimmerWidget extends StatelessWidget {
  final Widget child;
  final Color? baseColor;
  final Color? highlightColor;

  const ShimmerWidget({
    required this.child,
    this.baseColor,
    this.highlightColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Listen to NightModeCubit to get the current theme state
    bool isDarkMode = context.watch<NightModeCubit>().state;

    // Determine shimmer colors based on the theme
    final baseColor =
        this.baseColor ?? (isDarkMode ? Colors.grey[700]! : Colors.grey[300]!);
    final highlightColor = this.highlightColor ??
        (isDarkMode ? Colors.grey[400]! : Colors.grey[100]!);

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: child,
    );
  }
}
