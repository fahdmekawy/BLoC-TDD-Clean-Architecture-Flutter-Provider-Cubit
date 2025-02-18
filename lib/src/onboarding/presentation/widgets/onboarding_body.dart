import 'package:education_app_tutorial/core/extensions/context_extension.dart';
import 'package:education_app_tutorial/core/theme/colors.dart';
import 'package:education_app_tutorial/core/theme/text_styles.dart';
import 'package:education_app_tutorial/src/onboarding/domain/entities/page_content.dart';
import 'package:education_app_tutorial/src/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingBody extends StatelessWidget {
  const OnboardingBody({required this.pageContent, super.key});

  final PageContent pageContent;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(pageContent.image, height: context.height * 0.4),
        SizedBox(height: context.height * 0.05),
        Padding(
          padding: const EdgeInsets.all(20).copyWith(bottom: 0),
          child: Column(
            children: [
              Text(
                pageContent.title,
                textAlign: TextAlign.center,
                style: AppTextStyles.font40AeonikBlackBold,
              ),
              SizedBox(height: context.height * 0.02),
              Text(
                pageContent.description,
                textAlign: TextAlign.center,
                style: AppTextStyles.font14AeonikBlack,
              ),
              SizedBox(height: context.height * 0.05),
              ElevatedButton(
                onPressed: () =>
                    context.read<OnboardingCubit>().cacheFirstTime(),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 17,
                  ),
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  'Get Started',
                  style: AppTextStyles.fontAeonikBlackBold,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
