import 'package:flutter/material.dart';
import 'package:myhabits/Levels/LevelOne/LevelOne.dart';
import 'package:myhabits/Screens/AvatarScreen.dart';
import 'package:myhabits/Screens/DevelopersScreen.dart';
import 'package:myhabits/Screens/HomeScreen.dart';
import 'package:myhabits/Screens/Instructions.dart';
import 'package:myhabits/Screens/Setting.dart';
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
  // static const String InformationAboutRoute = "/InformationAboutpage";
  // static const String HowToGetRoute = "/HowToGetRoutepage";
  // static const String decisionsRoute = "/decisionspage";
  // static const String SginUpRoute = "/SginUpPage";
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
      //
      //
      //    case Routes.puzzleOrder:
      // return MaterialPageRoute(
      //   builder: (context) => PuzzleOrder(),
      // );

      default:
        return null;
    }
  }
}
