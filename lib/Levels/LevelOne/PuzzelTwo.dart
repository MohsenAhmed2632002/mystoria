import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mystoria/Core/Images&colors.dart';
import 'package:mystoria/Core/constants.dart';
import 'package:mystoria/Core/soundManger.dart';
import 'package:mystoria/Models/QuestionModel.dart';
import 'package:mystoria/Screens/feedackScreen.dart';
import 'package:mystoria/cubit/Gamecubit/game_cubit.dart';

class McqWidget extends StatelessWidget {
  final QuestionModel question;

  const McqWidget({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return GameScreen(
      hint: question.hint,
      color: question.color,
      background: question.background,
      mediaQueryRight: 0,
      mediaQueryTop: 0,
      child: Container(
        // color: Colors.cyan,
        height: MediaQuery.sizeOf(context).height * 0.9,
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: question.options.map((option) {
                return GameButtonTwo(
                  text: option,
                  onPressed: () {
                    // final cubit = context.read<GameCubit>();

                    if (option == question.correctAnswer) {
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
                  fromWidth: 350,
                  fromHeight: 150,
                  fontSize: 35,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
