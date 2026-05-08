import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mystoria/Core/Images&colors.dart';
import 'package:mystoria/Core/constants.dart';
import 'package:mystoria/Core/soundManger.dart';
import 'package:mystoria/Models/QuestionModel.dart';
import 'package:mystoria/Screens/feedackScreen.dart';
import 'package:mystoria/cubit/Gamecubit/game_cubit.dart';

class LevelTwoPuzzeleOne extends StatefulWidget {
  final QuestionModel question;

  const LevelTwoPuzzeleOne({super.key, required this.question});
  @override
  State<LevelTwoPuzzeleOne> createState() => _LevelTwoPuzzeleOneViewState();
}

class _LevelTwoPuzzeleOneViewState extends State<LevelTwoPuzzeleOne> {
  final List<String> userOrder = [];

  @override
  Widget build(BuildContext context) {
    return GameScreen(
      color: widget.question.color,
      hint: widget.question.hint,

      background: widget.question.background,
      mediaQueryRight: MediaQuery.sizeOf(context).width * 0,
      mediaQueryTop: MediaQuery.sizeOf(context).height * 0.2,
      child: Container(
        // color: Colors.lightGreenAccent,
        height: MediaQuery.sizeOf(context).height * 0.7,
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: widget.question.options.map((option) {
                return GameButtonThree(
                  text: option,
                  onPressed: () {
                    // final cubit = context.read<GameCubit>();

                    if (option == widget.question.correctAnswer) {
                      userOrder.clear();
                      SoundManager.instance.click();

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
                    } else {
                      SoundManager.instance.wrong();
                      userOrder.clear();
                      SoundManager.instance.click();

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
                  fromWidth: 450,
                  fromHeight: 250,
                  fontSize: 35,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  // // 🚪 الباب
  // Widget _buildChoicesContainer(String image) {
  //   return Draggable<String>(
  //     data: image,
  //     childWhenDragging: _card(image, faded: true),
  //     // السحب
  //     feedback: _card(image, dragging: true),
  //     child: _card(image),
  //   );
  // }

  // Widget _card(String text, {bool dragging = false, bool faded = false}) {
  //   return Opacity(
  //     opacity: faded ? 0.5 : 1,
  //     child: Column(children: [Image.asset(text, width: 300.w)]),
  //   );
  // }

  // // ✅ التحقق من الحل
  // void _checkResult() async {
  //   if (userOrder.length < 4) return;

  //   bool isCorrect = true;

  //   widget.question.correctAnswer.forEach((key, value) {
  //     if (userOrder[key] != value) {
  //       isCorrect = false;
  //     }
  //   });

  //   if (isCorrect) {
  //     // setState(() {
  //       // _rghitAnswer2 = true;
  //     // });
  //     onCorrect(context);
  //   } else {
  //     setState(() {
  //       _rghitAnswer = false;
  //     });

  //     // restartAllAnimations();

  //     onWrong(context);
  //     userOrder.clear();
  //     setState(() {});
  //   }
  // }
}
