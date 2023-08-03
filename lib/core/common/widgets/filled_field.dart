import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../resources/colours.dart';

class FilledField extends StatelessWidget {
  const FilledField({
    super.key,
    this.readOnly = false,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.hintStyle,
    this.keyboardType,
  });

  final TextEditingController? controller;
  final bool readOnly;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(16),
    );
    return TextField(
      controller: controller,
      //? Klavye dışında bir yere tıklanıldığı zaman ,klavyenin kapatılması için kullanılıyor.
      onTapOutside: (_) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      readOnly: readOnly,
      keyboardType: keyboardType,
      style: GoogleFonts.poppins(
        fontSize: 18,
        color: AppColours.kBackgroundBlack,
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColours.kLight,
        suffixIcon: suffixIcon,
        hintText: hintText,
        prefixIcon: prefixIcon,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 5,
        ),
        focusedBorder: border,
        enabledBorder: border,
      ),
    );
  }
}
