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

class FindMistakeWidget extends StatefulWidget {
  final QuestionModel question;

  const FindMistakeWidget({super.key, required this.question});

  @override
  State<FindMistakeWidget> createState() => _FindMistakeWidgetState();
}

class _FindMistakeWidgetState extends State<FindMistakeWidget> {
  @override
  Widget build(BuildContext context) {
    return GameScreen(
      color: widget.question.color,
      hint: widget.question.hint,

      background: widget.question.background,
      mediaQueryRight: 0,
      mediaQueryTop: MediaQuery.sizeOf(context).height * 0.1,
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height * 0.9,
        // color: Colors.amber,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppImages.paper, width: 700.w, height: 700.h),
            Container(
              width: MediaQuery.sizeOf(context).width,
              height: 100.h,
              child: Wrap(
                alignment: WrapAlignment.spaceEvenly,
                children: widget.question.options.map((word) {
                  final isWrongWord = word == widget.question.correctAnswer;

                  return GameButtonTwo(
                    text: word,
                    onPressed: () async {
                      if (isWrongWord) {
                        SoundManager.instance.correct();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FeedackScreen(
                              isCorrect: true,
                              stars: BlocProvider.of<GameCubit>(
                                context,
                              ).calculateStars(),
                              helps: BlocProvider.of<GameCubit>(
                                context,
                              ).state.theGame.attempts,
                              timeLeft: BlocProvider.of<GameCubit>(
                                context,
                              ).state.theGame.timeLeft,
                            ),
                          ),
                        );
                      } else {
                        SoundManager.instance.wrong();

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FeedackScreen(
                              isCorrect: false,
                              stars: 0,
                              helps:
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
                    fromWidth: 350,
                    fromHeight: 150,
                    fontSize: 50,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      // ),
      // ),
    );
  }
}
