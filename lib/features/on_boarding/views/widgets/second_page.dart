import 'package:advanced_todo_app/core/common/widgets/round_button.dart';
import 'package:advanced_todo_app/features/authentication/views/sign_in_screen.dart';
import 'package:flutter/material.dart';

import '../../../../core/common/widgets/white_space.dart';
import '../../../../core/resources/image_res.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(ImageRes.todo),
          const WhiteSpace(height: 10),
          RoundButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const SignInScreen()));
            },
            text: 'Login with Phone',
          )
        ],
      ),
    );
  }
}
