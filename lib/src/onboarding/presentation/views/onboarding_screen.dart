import 'package:education_app_tutorial/core/common/views/loading_view.dart';
import 'package:education_app_tutorial/core/common/widgets/gradient_background.dart';
import 'package:education_app_tutorial/core/extensions/context_extension.dart';
import 'package:education_app_tutorial/core/theme/colors.dart';
import 'package:education_app_tutorial/core/res/media_res.dart';
import 'package:education_app_tutorial/src/onboarding/domain/entities/page_content.dart';
import 'package:education_app_tutorial/src/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:education_app_tutorial/src/onboarding/presentation/widgets/onboarding_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  static const routeName = '/';

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final pageController = PageController();

  @override
  void initState() {
    super.initState();
    context.read<OnboardingCubit>().checkIfUserIsFirstTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GradientBackground(
        image: MediaRes.onBoardingBackground,
        child: BlocConsumer<OnboardingCubit, OnboardingCubitState>(
          listener: (context, state) {
            if (state is OnboardingStatus && !state.isFirstTime) {
              context.pushReplacementNamed('/home');
            } else if (state is UserCached) {
              // TODO(User-Cached-Handler): Push to the appropriate screen.
            }
          },
          builder: (context, state) {
            if (state is CachingIfUserFirstTime || state is CachingFirstTime) {
              return const LoadingView();
            }
            return Stack(
              children: [
                PageView(
                  controller: pageController,
                  children: const [
                    OnboardingBody(pageContent: PageContent.first()),
                    OnboardingBody(pageContent: PageContent.second()),
                    OnboardingBody(pageContent: PageContent.third()),
                  ],
                ),
                Align(
                  alignment: const Alignment(0, 0.10),
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: 3,
                    onDotClicked: (index) {
                      pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    },
                    effect: const WormEffect(
                      dotHeight: 8,
                      dotWidth: 20,
                      spacing: 20,
                      activeDotColor: AppColors.primaryColor,
                      dotColor: Colors.white,
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
