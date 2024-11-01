import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/routes/app_router.dart';

class NotRobotCubit extends Cubit<void> {
  final AnimationController scaleController;
  final AnimationController checkController;
  final BuildContext context;

  NotRobotCubit({
    required this.scaleController,
    required this.checkController,
    required this.context,
  }) : super(null) {
    _init();
  }

  void _init() {
    scaleController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        checkController.forward();
      }
    });
    scaleController.forward();

    checkController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        scaleController.reverse();
        checkController.reverse();
        Future.delayed(const Duration(milliseconds: 795), () {
          context.go(AppRouter.kSignUp);
        });
      }
    });
  }

  @override
  Future<void> close() {
    scaleController.dispose();
    checkController.dispose();
    return super.close();
  }
}
