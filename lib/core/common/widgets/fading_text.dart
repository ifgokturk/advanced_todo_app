import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../resources/colours.dart';

class FadingText extends StatelessWidget {
  const FadingText(
    this.text, {
    Key? key,
     this.colour,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
  }) : super(key: key);

  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? colour;
  final TextAlign? textAlign;
  @override
  Widget build(BuildContext context) {
    return Text(text,
        maxLines: 1,
        softWrap: false,
        overflow: TextOverflow.ellipsis,
        textAlign: textAlign ?? TextAlign.left,
        style: GoogleFonts.poppins(
          fontSize: fontSize,
          fontWeight: fontWeight ?? FontWeight.normal,
          color: colour ?? AppColours.kLight,
        ));
  }
}
