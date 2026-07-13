import 'package:flutter/material.dart';
import 'package:todo_app/extensions/context_extension.dart';
import 'package:todo_app/models/onboarding_slide_model.dart';

class OnboardingSlideContent extends StatelessWidget {
  final OnboardingSlideModel slide;

  const OnboardingSlideContent({super.key, required this.slide});

  @override
  Widget build(BuildContext context) {
    final height = context.height;

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: height * 0.03,
        children: [_buildImage(context), _buildTextContent(context)],
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    final width = context.width;
    // final height = context.height;

    return Container(
      padding: EdgeInsets.fromLTRB(width * 0.07, 0, width * 0.07, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(slide.imageUrl, fit: BoxFit.contain),
      ),
    );
  }

  Widget _buildTextContent(BuildContext context) {
    final text = context.text;
    final colors = context.colors;
    final height = context.height;

    return Column(
      spacing: height * 0.015,
      children: [
        Text(
          slide.title,
          style: text.titleLarge!.copyWith(color: colors.onPrimary),
          textAlign: TextAlign.center,
        ),
        Text(
          slide.detail,
          style: text.bodyLarge!.copyWith(color: colors.onPrimary),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
