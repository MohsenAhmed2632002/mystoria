import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myhabits/Core/Font.dart';
import 'package:myhabits/Core/Images&colors.dart';
import 'package:myhabits/Core/constants.dart';
import 'package:myhabits/Core/soundManger.dart';
import 'package:myhabits/Models/QuestionModel.dart';
import 'package:myhabits/Screens/feedackScreen.dart';
import 'package:myhabits/cubit/Gamecubit/game_cubit.dart';

class LevelTwoPuzzeleTwo extends StatefulWidget {
  final QuestionModel question;

  LevelTwoPuzzeleTwo({super.key, required this.question});

  @override
  State<LevelTwoPuzzeleTwo> createState() => _LevelTwoPuzzeleTwoState();
}

class _LevelTwoPuzzeleTwoState extends State<LevelTwoPuzzeleTwo> {
  bool freezGame = false;
  int wrongCount = 0;

  @override
  Widget build(BuildContext context) {
    return GameScreen(
      hint: widget.question.hint,
      color: widget.question.color,
      background: widget.question.background,
      mediaQueryRight: 0,
      mediaQueryTop: MediaQuery.sizeOf(context).height * 0.75,
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: widget.question.options.map((option) {
            return GameButtonThree(
              text: option,
              onPressed: () {
                if (freezGame) return;

                // ✅ الإجابة الصحيحة
                if (option == widget.question.correctAnswer) {
                  SoundManager.instance.correct();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FeedackScreen(
                        isCorrect: true,
                        stars: BlocProvider.of<GameCubit>(
                          context,
                        ).calculateStars(),
                        attempts: BlocProvider.of<GameCubit>(
                          context,
                        ).state.theGame.attempts,
                        timeLeft: BlocProvider.of<GameCubit>(
                          context,
                        ).state.theGame.timeLeft,
                      ),
                    ),
                  );
                  return; // ← مهم جداً: لا تكمل باقي الكود
                }

                // ❌ الإجابة الخاطئة
                if (wrongCount == 0) {
                  wrongCount++;
                  SoundManager.instance
                      .lamp(); // إذا كان هذا يسبب "هنت" غير مرغوب، علقه
                  _firstWrong(context);
                } else {
                  SoundManager.instance.wrong();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FeedackScreen(
                        isCorrect: false,
                        stars: 0,
                        attempts:
                            BlocProvider.of<GameCubit>(
                              context,
                            ).state.theGame.attempts -
                            1,
                        timeLeft: BlocProvider.of<GameCubit>(
                          context,
                        ).state.theGame.timeLeft,
                      ),
                    ),
                  );
                }
              },
              fontSize: 30,
              fromWidth: 450,
              fromHeight: 250,
            );
          }).toList(),
        ),

        //  SizedBox(
        //   width: 2000.w,
        //   height: 1000.h,
        //   child: GridView.builder(
        //     itemCount: widget.question.options.length,
        //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //       crossAxisCount: 2,
        //       mainAxisSpacing: 40,
        //       crossAxisSpacing: 40,
        //       childAspectRatio: 3,
        //     ),
        //     itemBuilder: (context, index) {
        //       final option = widget.question.options[index];

        //       return GameButtonThree(
        //         text: option,
        //         onPressed: () async {
        //           if (freezGame) return;

        //           /// الإجابة الصحيحة
        //           if (option == widget.question.correctAnswer) {
        //             SoundManager.instance.correct();
        //             onCorrect(context);
        //             return;
        //           }

        //           /// الإجابة الخاطئة
        //           wrongCount++;

        //           if (wrongCount == 1) {
        //             SoundManager.instance.lamp();
        //             await _firstWrong(context);
        //           } else {
        //             SoundManager.instance.wrong();

        //             onWrong(context);
        //           }
        //         },
        //         fromWidth: 0,
        //         fromHeight: 0,
        //         fontSize: 50,
        //       );
        //     },
        //   ),
        // ),
      ),
    );
  }

  Future<void> _firstWrong(BuildContext context) async {
    freezGame = true;
    setState(() {});

    SoundManager.instance.lamp();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(30.w),
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(AppImages.dialog)),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              "حاول مرة اخرى",
              style: getRegulerTextStyle(
                context: context,
                fontSize: 80.sp,
                color: AppColors.accentColor,
              ),
            ),
          ),
        ),
      ),
    );

    await Future.delayed(const Duration(seconds: 5));

    if (mounted) Navigator.pop(context);

    freezGame = false;
    setState(() {});
  }
}
