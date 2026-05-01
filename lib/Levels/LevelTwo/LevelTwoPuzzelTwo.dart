import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mystoria/Core/Font.dart';
import 'package:mystoria/Core/Images&colors.dart';
import 'package:mystoria/Core/constants.dart';
import 'package:mystoria/Core/soundManger.dart';
import 'package:mystoria/Models/QuestionModel.dart';
import 'package:mystoria/Screens/feedackScreen.dart';
import 'package:mystoria/cubit/Gamecubit/game_cubit.dart';

class LevelTwoPuzzeleTwo extends StatefulWidget {
  final QuestionModel question;

  const LevelTwoPuzzeleTwo({super.key, required this.question});

  @override
  State<LevelTwoPuzzeleTwo> createState() => _LevelTwoPuzzeleTwoState();
}

class _LevelTwoPuzzeleTwoState extends State<LevelTwoPuzzeleTwo> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GameCubit>(context).initState(context);
  }

  bool freezGame = false;

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
              fromHeight: 200,
            );
          }).toList(),
        ),
      ),
    );
  }
}
