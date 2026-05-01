import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mystoria/Core/Routes.dart';
import 'package:mystoria/Core/constants.dart';
import 'package:mystoria/Core/Images&colors.dart';
import 'package:mystoria/Core/soundManger.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // 🎨 الخلفية
          SizedBox.expand(
            child: Image.asset(AppImages.homeScreen, fit: BoxFit.fill),
          ),
          ThereButtons(),
          DevAndSettingIcon(),
        ],
      ),
    );
  }
}

class ThereButtons extends StatelessWidget {
  const ThereButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: MediaQuery.sizeOf(context).height * 0.25,
      top: MediaQuery.sizeOf(context).width * 0.15,

      child: Column(
        children: [
          GameButton(
            text: 'ابدأ اللعبة',
            onPressed: () {
              SoundManager.instance.click();
              Navigator.pushNamed(context, Routes.levelMapScreen);
            },
            fromWidth: 500,
            fromHeight: 200,
          ),
          GameButton(
            fromWidth: 500,
            fromHeight: 200,
            text: 'التعليمات',
            onPressed: () {
              SoundManager.instance.click();
              Navigator.pushNamed(context, Routes.instructions);
            },
          ),
          GameButton(
            fromWidth: 500,
            fromHeight: 200,
            text: 'خروج',
            onPressed: () {
              SoundManager.instance.click();
              Navigator.pushNamed(context, Routes.escScreen);
              // showDialog(
              //   context: context,
              //   builder: (_) => AlertDialog(
              //     title: const Text('تأكيد الخروج'),
              //     content: const Text('هل تريد الخروج من اللعبة؟'),
              //     actions: [
              //       TextButton(
              //         onPressed: () => Navigator.pop(context),
              //         child: const Text('لا'),
              //       ),
              //       TextButton(
              //         onPressed: () {
              //           SystemNavigator.pop();
              //         },
              //         child: const Text('نعم'),
              //       ),
              //     ],
              //   ),
              // );
            },
          ),
        ],
      ),
    );
  }
}
