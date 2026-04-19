import 'package:flutter/material.dart';
import 'package:mystoria/Core/constants.dart';
import 'package:mystoria/Core/Images&colors.dart';

class Instructions extends StatelessWidget {
  const Instructions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // 🎨 الخلفية
          SizedBox.expand(
            child: Image.asset(AppImages.instructions, fit: BoxFit.fill),
          ),

          DownLeftButton(),
        ],
      ),
    );
  }
}

class InstructionsTwo extends StatelessWidget {
  const InstructionsTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // 🎨 الخلفية
          SizedBox.expand(
            child: Image.asset(AppImages.instructions2, fit: BoxFit.fill),
          ),
          LeftButtonTwo(),
        ],
      ),
    );
  }
}
