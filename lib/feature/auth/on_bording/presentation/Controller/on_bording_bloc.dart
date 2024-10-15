

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:telegram/core/utililes/app_assets/assets_strings.dart';
import 'package:telegram/feature/auth/on_bording/presentation/Controller/on_bording_state.dart';
import 'package:telegram/feature/auth/on_bording/data/models/on_bording_model.dart';

class OnBordingCubit extends Cubit<OnBordingState> {
  OnBordingCubit()
      : super(OnBordingState(

          currentPage: 0,
          controller: PageController(),

          onBordingcontents: [
            OnboardingContents(
              title: "Welcome to Mazrof",
              image: AppAssetsStrings.on_bording1,
              desc: "Connect with friends and family instantly, no matter where they are.",
              count: "1/4",
            ),
            OnboardingContents(
              title: "Seamless Communication",
              image: AppAssetsStrings.on_bording2,
              desc: " Enjoy high-quality voice and video calls with just a tap.",
              count: "2/4",
            ),
            OnboardingContents(
              title: "Share Moments",
              image: AppAssetsStrings.on_bording3,
              desc: "Send photos, videos, and files effortlessly to keep everyone in the loop.",
              count: "3/4",
            ),
             OnboardingContents(
              title: "One Chat, Endless Possibilities",
              image: AppAssetsStrings.on_bording4,
              desc: "Dive into a world of endless conversations and connections.",
              count: "4/4",
            ),


          ],
        ));


  // Update the current page index
  void updateCurrentPage(int val) {
    emit(state.copyWith(currentPage: val));
  }


}

