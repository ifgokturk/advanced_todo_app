import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../resources/colours.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.backgroundColour,
    this.borderColour,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String text;
  final Color? backgroundColour;
  final Color? borderColour;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColour ?? AppColours.kLight,
          minimumSize: Size(size.width * .9, size.height * .06),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: borderColour == null
                ? BorderSide.none
                : BorderSide(
                    color: borderColour!,
                  ),
          )),
      onPressed: onPressed,
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: borderColour ?? AppColours.kBackgroundBlack,
        ),
      ),
    );
  }
}
