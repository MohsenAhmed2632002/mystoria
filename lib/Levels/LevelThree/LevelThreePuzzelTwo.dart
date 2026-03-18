import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myhabits/Core/Images&colors.dart';
import 'package:myhabits/Core/constants.dart';
import 'package:myhabits/Core/soundManger.dart';
import 'package:myhabits/Models/QuestionModel.dart';

class LevelThreePuzzeleTwo extends StatefulWidget {
  final QuestionModel question;

  const LevelThreePuzzeleTwo({super.key, required this.question});

  @override
  State<LevelThreePuzzeleTwo> createState() => _LevelThreePuzzeleTwoState();
}

class _LevelThreePuzzeleTwoState extends State<LevelThreePuzzeleTwo> {
  late Timer _timer;

  bool isLightOn = true;
  // bool gameFinished = false;

  @override
  void initState() {
    super.initState();
    _startBlinking();
  }

  void _startBlinking() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // if (!gameFinished) {
      setState(() {
        isLightOn = !isLightOn;
      });
      // }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _select(String answer) async {
    // ❌ لو الغرفة مظلمة مفيش اختيار
    if (!isLightOn
    // || gameFinished
    )
      return;

    _timer.cancel();

    if (answer == widget.question.correctAnswer) {
      // ✅ إجابة صحيحة
      setState(() {
        // gameFinished = true;
        isLightOn = true; // تثبيت النور
      });

      SoundManager.instance.openLamp();

      // await Future.delayed(const Duration(milliseconds: 500));
      onCorrect(context);
    } else {
      // ❌ إجابة خاطئة
      setState(() {
        // gameFinished = true;
        isLightOn = false; // تثبيت الظلام
      });

      SoundManager.instance.doorMakbara();

      // await Future.delayed(const Duration(milliseconds: 500));

      _restartGame();
      onWrong(context);
    }
  }

  void _restartGame() {
    // setState(() {
    // gameFinished = false;
    // });

    _startBlinking();
  }

  @override
  Widget build(BuildContext context) {
    return GameScreen(
      mediaQueryRight: 0,
      mediaQueryTop: MediaQuery.of(context).size.height * 0.1,
      hint: widget.question.hint,
      color: widget.question.color,

      background: isLightOn
          ? AppImages
                .roomLight // الخلفية المنورة
          : AppImages.roomDark, // الخلفية المظلمة
      child:
          /// التمثالين
          Container(
            height: MediaQuery.of(context).size.height * 0.9,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// حتشبسوت
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(AppImages.lamp, width: 250.w, height: 250.h),
                    Image.asset(
                      AppImages.hatshbsoot,
                      width: 150.w,
                      height: 550.h,
                    ),
                    GameButtonLight(
                      text: widget.question.options[0],
                      onPressed: () {
                        _select(widget.question.options[0]);
                      },
                      fromWidth: 300,
                      fromHeight: 100,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(AppImages.lamp, width: 250.w, height: 250.h),

                    Image.asset(AppImages.ahmose, width: 220.w, height: 550.h),
                    GameButtonLight(
                      text: widget.question.options[1],
                      onPressed: () {
                        _select(widget.question.options[1]);
                      },
                      fromWidth: 300,
                      fromHeight: 100,
                    ),
                  ],
                ),
              ],
            ),
          ),
    );
  }
}
