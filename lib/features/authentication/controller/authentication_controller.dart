import 'package:advanced_todo_app/features/authentication/repository/authentication_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authControllerProvider = Provider((ref) {
  return AuthenticationController(ref.watch(authRepoProvider));
});



class AuthenticationController {
  const AuthenticationController(this.repository);

  final AuthenticationRepository repository;

  Future<void> sendOTP({
    required BuildContext context,
    required String phoneNumber,
  }) async {
    return repository.sendOTP(context: context, phoneNumber: phoneNumber);
  }
}
