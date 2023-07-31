

import 'package:advanced_todo_app/core/utils/core_utils.dart';
import 'package:advanced_todo_app/features/authentication/views/otp_verification_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


final authRepoProvider =
Provider(
  (ref) => AuthenticationRepository(auth: FirebaseAuth.instance));


class AuthenticationRepository {
  //?For TDD
  const AuthenticationRepository({required this.auth});

  final FirebaseAuth auth;

  Future<void> sendOTP(
      {required BuildContext context, required String phoneNumber}) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (credential) {
        auth.signInWithCredential(credential);
      },
      verificationFailed: (exception) {
CoreUtils.showSnackBar(
  context: context,message:
'${exception.code} : ${exception.message}',);
      },
      codeSent: (verificationId, _) {
        Navigator.push(context, MaterialPageRoute(
            builder: (_)=> const OTPVerificationScreen(),),);
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

  //? SQLITE

Future<void> verifyOTP({
    required BuildContext context, required String verificationId,
  required String otp,
}) async {
    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId, smsCode: otp,
    );

    final userCredential = await auth.signInWithCredential(credential);

    if (userCredential.user != null){
      // TODO(Save-User) Save User Data to their device

    }



}


}
