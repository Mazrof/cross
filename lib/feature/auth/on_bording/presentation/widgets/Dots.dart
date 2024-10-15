import 'package:flutter/material.dart';
import 'package:telegram/feature/auth/on_bording/presentation/widgets/build_dot.dart';

class Dots extends StatelessWidget {
  const Dots({
    super.key,
    required this.currentPage,
  });
  final int currentPage;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        4,
        (int index) =>BuildDot(currentPage:currentPage,index: index,),
      ),
    );
  }
}
