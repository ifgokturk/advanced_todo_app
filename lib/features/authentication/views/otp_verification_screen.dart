import 'package:advanced_todo_app/core/common/widgets/white_space.dart';
import 'package:advanced_todo_app/core/resources/colours.dart';
import 'package:advanced_todo_app/core/resources/image_res.dart';
import 'package:advanced_todo_app/features/authentication/controller/authentication_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pinput/pinput.dart';

import '../../../core/utils/core_utils.dart';

class OTPVerificationScreen extends ConsumerWidget {
  const OTPVerificationScreen({required this.verificationId, super.key});

  final String verificationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(ImageRes.todo),
                  const WhiteSpace(
                    height: 26,
                  ),
                  // 6 digit OTP code
                  Pinput(
                    keyboardType: TextInputType.phone,
                    length: 6,
                    // TODO: (Verify-OTP) Send OTP to Firebase for verification
                    onCompleted: (pin) async {

                      CoreUtils.showLoader(context);
                      await ref.read(authControllerProvider).verifyOTP(
                            context: context,
                            verificationId: verificationId,
                            otp: pin,
                          );

                    },
                    defaultPinTheme: PinTheme(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          color: AppColours.kLight,
                          borderRadius: BorderRadius.circular(8),
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
