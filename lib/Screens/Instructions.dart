import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myhabits/Core/Font.dart';
import 'package:myhabits/Core/constants.dart';
import 'package:myhabits/Core/Images&colors.dart';

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
            child: Image.asset(AppImages.instructions, fit: BoxFit.fill),
          ),
          LeftButtonTwo(),
        ],
      ),
    );
  }
}
