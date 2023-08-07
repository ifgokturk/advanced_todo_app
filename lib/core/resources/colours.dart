import 'dart:math';
import 'dart:ui';

class AppColours {
  const AppColours._();

  static const Color kBackgroundBlack = Color(0xFF2a2b2e);
  static const Color kLight = Color(0xFFFFFFFF);
  static const Color kRed = Color(0xffa8115d);
  static const Color kBlueLight = Color(0xff31a2c9);
  static const Color kGreyDark = Color(0xff656569);
  static const Color kLightGrey = Color(0xff7c7d86);
  static const Color kGreen = Color(0xff6ac01a);
  static const Color kYellow = Color(0xffdcd33b);
  static const Color kBackgroundLight = Color(0x58797777);
  static const Color kGreyBackground = Color(0xFF202C33);

  static const colors =  [
    Color(0xffd80000),
    Color(0xff18a3a8),
    Color(0xffb61dae),
    Color(0xff4ac029),
    Color(0xffd9d622),
    Color(0xffec7b1e),
  ];


  static   Color randomColor() {
    final random = Random();
    int randomIndex = random.nextInt(AppColours.colors.length);
    return AppColours.colors[randomIndex];
  }

}
