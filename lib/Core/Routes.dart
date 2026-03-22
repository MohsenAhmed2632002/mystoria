import 'package:flutter/material.dart';
import 'package:myhabits/Levels/LevelOne/LevelOne.dart';
import 'package:myhabits/Screens/AvatarScreen.dart';
import 'package:myhabits/Screens/AwardScreen.dart';
import 'package:myhabits/Screens/DevelopersScreen.dart';
import 'package:myhabits/Screens/HomeScreen.dart';
import 'package:myhabits/Screens/Instructions.dart';
import 'package:myhabits/Screens/Setting.dart';
import 'package:myhabits/Screens/escScreen.dart';
import 'package:myhabits/Screens/feedackScreen.dart';
import 'package:myhabits/Screens/hintScreen.dart';
import 'package:myhabits/Screens/splashscreen.dart';
import 'package:myhabits/Screens/levelMapScreen.dart';

class Routes {
  static const String splashRoute = "/splashRoute";
  static const String instructions = "/Instructions";
  static const String instructions2 = "/Instructions2";
  static const String puzzleOrder = "/PuzzleOrder";
  static const String loginRoute = "/loginRoute";
  static const String homeScreen = "/HomeScreen";
  static const String settingScreen = "/SettingScreen";
  static const String levelMapScreen = "/LevelMapScreen";
  static const String developersScreen = "/DevelopersScreen ";
  static const String avatarScreen = "/avatarScreen";
  static const String awardScreen = "/AwardScreen";
  static const String hintScreen = "/hintScreen";
  static const String escScreen = "/escScreen";
  static const String feedbackScreen = "/feedbackScreen";
  // static const String FieldeducationRoute = "/FieldeducationPage";
  // static const String LectureSchedulePage = "/LectureSchedulePage";
  // static const String SectionSchedulePage = "/SectionSchedulePage";
}

class RoutesGenerator {
  static Route<dynamic>? getRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (context) => SplashScreen());

      case Routes.instructions:
        return MaterialPageRoute(builder: (context) => Instructions());
      case Routes.instructions2:
        return MaterialPageRoute(builder: (context) => InstructionsTwo());

      case Routes.homeScreen:
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case Routes.puzzleOrder:
        return MaterialPageRoute(builder: (context) => LevelOne());
      case Routes.developersScreen:
        return MaterialPageRoute(builder: (context) => DevelopersScreen());
      case Routes.settingScreen:
        return MaterialPageRoute(builder: (context) => SettingScreen());
      case Routes.levelMapScreen:
        return MaterialPageRoute(builder: (context) => LevelMapScreen());
      case Routes.avatarScreen:
        return MaterialPageRoute(builder: (context) => AvatarScreen());

      case Routes.awardScreen:
        return MaterialPageRoute(builder: (context) => AwardScreen());
      // FeedBackScreen
      // case Routes.feedbackScreen:
      //   return MaterialPageRoute(
      //     builder: (context) =>
      //         FeedbackScreen(isCorrect: true, helps: 1, timeLeft: 21),
      //   );
      case Routes.hintScreen:
        final String hint =
            settings.arguments as String; // أو نوع الـ hint الخاص بك

        return MaterialPageRoute(builder: (context) => HintScreen(hint: hint));
      case Routes.escScreen:
        return MaterialPageRoute(builder: (context) => EscScreen());

      default:
        return null;
    }
  }
}
