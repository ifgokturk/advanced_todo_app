import 'package:advanced_todo_app/core/common/widgets/fading_text.dart';
import 'package:advanced_todo_app/core/common/widgets/white_space.dart';
import 'package:advanced_todo_app/core/resources/colours.dart';
import 'package:advanced_todo_app/core/resources/image_res.dart';
import 'package:advanced_todo_app/features/on_boarding/views/widgets/first_page.dart';
import 'package:advanced_todo_app/features/on_boarding/views/widgets/second_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// OnboardingScreen
// Image
// title
// subTitle
//skip
// swipe indicator
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final pageController = PageController();
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            PageView(
              controller: pageController,
              children: const [
                FirstPage(),
                SecondPage(),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0)
                  .copyWith(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.bounceInOut,
                      );
                    },
                    child: const Row(
                      children: [
//Button
                        Icon(
                          Ionicons.chevron_forward_circle,
                          size: 30,
                          color: AppColours.kLight,
                        ),
                        WhiteSpace(width: 10),
                        //Skip Text
                        FadingText(
                          'Skip',
                          colour: AppColours.kLight,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ],
                    ),
                  ),
                  // Swipe indicator
                  SmoothPageIndicator(
                    controller: pageController,
                    count: 2,
                    effect: WormEffect(
                      dotHeight: 12,
                      spacing: 10,
                      dotColor: AppColours.kYellow.withOpacity(.5),
                      activeDotColor: AppColours.kLight,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
