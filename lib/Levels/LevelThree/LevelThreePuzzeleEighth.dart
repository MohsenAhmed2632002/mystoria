import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myhabits/Core/Images&colors.dart';
import 'package:myhabits/Core/animation_restart_mixin.dart';
import 'package:myhabits/Core/constants.dart';
import 'package:myhabits/Core/soundManger.dart';
import 'package:myhabits/Models/QuestionModel.dart';

class LevelThreePuzzeleEleven extends StatefulWidget {
  final QuestionModel question;

  const LevelThreePuzzeleEleven({super.key, required this.question});

  @override
  State<LevelThreePuzzeleEleven> createState() =>
      _LevelThreePuzzeleElevenState();
}

class _LevelThreePuzzeleElevenState extends State<LevelThreePuzzeleEleven> {
  int crackLevel = 1;

  @override
  void initState() {
    super.initState();

    SoundManager.instance.earthCracked();
  }

  @override
  Widget build(BuildContext context) {
    return GameScreen(
      hint: widget.question.hint,
      color: widget.question.color,
      background: widget.question.background,
      mediaQueryRight: 0,
      mediaQueryTop: MediaQuery.sizeOf(context).height * 0.1,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // _buildDoor(widget.question.options[0]),
                  GameButtonLight(
                    text: widget.question.options[0],
                    onPressed: () => _select(widget.question.options[0]),
                    fromWidth: 300,
                    fromHeight: 500,
                  ),
                  GameButtonLight(
                    text: widget.question.options[1],
                    onPressed: () => _select(widget.question.options[1]),
                    fromWidth: 500,
                    fromHeight: 300,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // _buildDoor(widget.question.options[0]),
                      GameButtonLight(
                        text: widget.question.options[2],
                        onPressed: () => _select(widget.question.options[2]),
                        fromWidth: 500,
                        fromHeight: 300,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          /// خلفية التصدع
          if (crackLevel == 2)
            Positioned(
              top: 770.h,

              left: 350.w,
              child: Image.asset(
                AppImages.incision,
                width: 200.w,
                height: 200.h,
              ),
            ),
        ],
      ),
    );
  }

  void _select(String option) async {
    // isLocked = true;

    if (option == widget.question.correctAnswer) {
      // SoundManager.instance.stopEarthCracked();
      // SoundManager.instance.correct();

      await Future.delayed(const Duration(milliseconds: 600));

      onCorrect(context);
    } else {
      /// تشقق أقوى
      setState(() {
        crackLevel = 2;
      });

      SoundManager.instance.falling(); // صوت وقوع

      await Future.delayed(const Duration(seconds: 1));

      /// رجوع للوضع الطبيعي
      setState(() {
        crackLevel = 1;
      });

      onWrong(context);

      // isLocked = false;
    }
  }
}
