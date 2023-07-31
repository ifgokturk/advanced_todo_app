
import 'package:advanced_todo_app/core/resources/colours.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CoreUtils {
  const CoreUtils._();
  static void showSnackBar({
    required BuildContext context,
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        //? account-exists-with different credential
        //? There is already on account that exists with that phone numver
        //? account exists with different credential there is  alreadry account that exist
        content: Text(message),
      ),
    );
  }

  static void showLoader(BuildContext context, {String? message})
  {
    showDialog(context: context,
        builder: (_)=>  Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center
            ,
            children: [

             const CircularProgressIndicator(color:Colors.blueAccent),
              if(message!= null )Text('$message .... ',
                style: GoogleFonts.poppins(
                  color: AppColours.kBlueLight,
                ),

              ),
            ],
          )
        ),);
  }
}
