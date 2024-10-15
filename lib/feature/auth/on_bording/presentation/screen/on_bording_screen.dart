import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:telegram/feature/auth/on_bording/presentation/Controller/on_bording_bloc.dart';
import 'package:telegram/feature/auth/on_bording/presentation/Controller/on_bording_state.dart';
import 'package:telegram/feature/auth/on_bording/presentation/widgets/Dots.dart';
import 'package:telegram/feature/auth/on_bording/presentation/widgets/onboarding_content.dart';
import 'package:telegram/feature/auth/on_bording/presentation/widgets/skip_next_button.dart';
import 'package:telegram/feature/auth/on_bording/presentation/widgets/start_button.dart';

class OnBordingScreen extends StatelessWidget {
  const OnBordingScreen({super.key});


  @override
  Widget build(BuildContext context) {

return  BlocBuilder<OnBordingCubit, OnBordingState>(
        builder: (context, state) {
          return Scaffold(
            
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: PageView.builder(
                      physics: const BouncingScrollPhysics(),
                      controller: state.controller,
                      onPageChanged: (value) =>
                          context.read<OnBordingCubit>().updateCurrentPage(value),

                      itemCount: state.onBordingcontents.length,

                      itemBuilder: (context, i) {
                        return OnboardingContent(
                            title: state.onBordingcontents[state.currentPage].title,
                            desc: state.onBordingcontents[state.currentPage].desc,
                            image: state.onBordingcontents[state.currentPage].image
                            );

                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Dots(currentPage:state.currentPage),
                        (state.currentPage == state.onBordingcontents.length - 1)

                            ? StartButton(width:  MediaQuery.of(context).size.width*.2)
                            : SkipNextButton(
                             jumptoPage2: () => context.read<OnBordingCubit>().updateCurrentPage(state.onBordingcontents.length-1),
                              jumptonextpage: () =>context.read<OnBordingCubit>().updateCurrentPage(state.currentPage+1),




                            )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
