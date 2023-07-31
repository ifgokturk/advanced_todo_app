import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/common/widgets/fading_text.dart';
import '../../../../core/common/widgets/white_space.dart';
import '../../../../core/resources/colours.dart';
import '../../../../core/resources/image_res.dart';


class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(ImageRes.todo),
            const WhiteSpace(height: 10),
            const FadingText(
              'Todo with Riverpod',
              textAlign: TextAlign.center,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              colour: AppColours.kLight,
            ),
            const WhiteSpace(height: 10),
            Text(
                'Welcome!!! Do you want to clear tasks super fast with TODO?',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: AppColours.kLightGrey,
                )),
          ],
        ),
      );

  }
}
