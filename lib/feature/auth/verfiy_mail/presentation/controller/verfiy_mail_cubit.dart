import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:telegram/feature/auth/verfiy_mail/presentation/controller/verfiy_mail_state.dart';

class VerifyMailCubit extends Cubit<VerifyMailState> {
  VerifyMailCubit(
      // this.verifyMailUseCase,
      // this.setTimerForAutoRedirectUseCase,
      // this.signOutUseCase,
      )
      : super(VerifyMailInitial());

  // final VerifyMailUseCase verifyMailUseCase;
  // final SetTimerForAutoRedirectUseCase setTimerForAutoRedirectUseCase;
  // final SignOutUseCase signOutUseCase;

  void init() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      sendVerificationMail();
      setTimerForAutoRedirect();
    });
  }

  void verifyMail(BuildContext context) {
    // CashHelper.saveData('isMailVerified', true);

    // Navigator.pushNamed(context, AppRoutes.success, arguments: {
    //   'title': AppStrings.mailVerifiedTitle,
    //   'subtitle': AppStrings.mailVerifiedSubTitle,
    //   'onButtonPressed': () => TAppLocalStorage.screenRedirect(),
    // });
  }

  // Send verification mail
  void sendVerificationMail() async {
    try {
      // await verifyMailUseCase();
      // CSnackBar.showSuccessSnackBar(
      //     'Email Sent', 'Please check your inbox and verify your email');
    } catch (e) {
      // Messages.showErrorSnackBar('Error', 'Error while sending email');
    }
  }

  // Timer for resend mail
  void setTimerForAutoRedirect() {
    Timer.periodic(const Duration(seconds: 30), (timer) async {
      // final result = await setTimerForAutoRedirectUseCase();
      //   result.fold(
      //     (failure) {
      //       Messages.showErrorSnackBar('Error', 'Error while sending email');
      //     },
      //     (isVerified) {
      //       if (isVerified) {
      //         timer.cancel();
      //         verifyMail();
      //       }
      //     },
      //   );
      // });
    });
  }

  // Logout
  void logout(BuildContext context) {
    // TAppLocalStorage.logout();
    // UserData.userModel = UserModel.emptyUser();
    // UserAccessToken.accessToken = '';
    // Navigator.pushNamedAndRemoveUntil(
    //     context, AppRoutes.login, (route) => false);
  }
}
