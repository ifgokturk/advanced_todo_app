import 'package:advanced_todo_app/core/common/widgets/filled_field.dart';
import 'package:advanced_todo_app/core/common/widgets/white_space.dart';
import 'package:advanced_todo_app/core/resources/colours.dart';
import 'package:advanced_todo_app/core/resources/image_res.dart';
import 'package:advanced_todo_app/core/utils/core_utils.dart';
import 'package:advanced_todo_app/features/authentication/app/country_code_provider.dart';
import 'package:advanced_todo_app/features/authentication/controller/authentication_controller.dart';
import 'package:advanced_todo_app/features/authentication/repository/authentication_repository.dart';
import 'package:advanced_todo_app/features/authentication/views/otp_verification_screen.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/common/widgets/round_button.dart';

class SignInScreen extends HookConsumerWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phoneController = useTextEditingController();
    final code = ref.watch(countryCodeProvider);
    final border = OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(16),
    );
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            children: [
              Image.asset(ImageRes.todo),
              WhiteSpace(
                height: 20.h,
              ),
              Text(
                'Please enter your number to get the verification code',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 17,
                  color: AppColours.kYellow,
                ),
              ),
              const WhiteSpace(height: 20),
FilledField(
  readOnly: code==null,
  controller: phoneController,
  keyboardType: TextInputType.phone,
  prefixIcon:
  Padding(
    padding: const EdgeInsets.only(top: 8.0, left: 10),
    child: GestureDetector(
        onTap: () {
          showCountryPicker(
            context: context,
            onSelect: (code) {
              ref.read(countryCodeProvider.notifier).changeCountry(code);
            },
            countryListTheme: CountryListThemeData(
              backgroundColor: AppColours.kBackgroundBlack,
              bottomSheetHeight: MediaQuery.of(context).size.height * .6,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              textStyle: GoogleFonts.poppins(
                fontSize: 18,
                color: AppColours.kLight,
                fontWeight: FontWeight.bold,
              ),
              searchTextStyle: GoogleFonts.poppins(
                fontSize: 18,
                color: AppColours.kLight,
                fontWeight: FontWeight.bold,
              ),
              inputDecoration: InputDecoration(
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 18,
                    color: AppColours.kLightGrey,
                    fontWeight: FontWeight.bold,
                  ),
                  hintText: 'Search',
                  border: const OutlineInputBorder(),
                  labelText: 'Search'),
            ),
          );
        },
        child: Text(
          code == null
              ? 'Pick country'
              : '${code.flagEmoji}+${code.phoneCode}',
          style: GoogleFonts.poppins(
            fontSize: code == null ? 13 : 18,
            color: code == null
                ? AppColours.kGreen
                : AppColours.kBackgroundBlack,
            fontWeight: FontWeight.bold,
          ),
        )),
  ),


),

              const WhiteSpace(height: 30),
              RoundButton(
                text: 'Send Code',
                onPressed: () async {
                  if (code == null) return;
                  final navigator = Navigator.of(context);
                  CoreUtils.showLoader(context);
                  await ref.read(authControllerProvider).sendOTP(
                        context: context,
                        phoneNumber:
                            '+${code.phoneCode}${phoneController.text}',
                      );
                  navigator.pop();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
