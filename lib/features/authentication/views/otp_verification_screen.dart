import 'package:advanced_todo_app/core/common/widgets/white_space.dart';
import 'package:advanced_todo_app/core/resources/colours.dart';
import 'package:advanced_todo_app/core/resources/image_res.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OTPVerificationScreen extends StatelessWidget {
  const OTPVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView
          (
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
                     onCompleted: (pin){

                     },
                     defaultPinTheme: PinTheme(
                       padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 16,),
                       decoration: BoxDecoration(
                         color: AppColours.kLight,
                         borderRadius: BorderRadius.circular(8),
                       )
                     ),
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
