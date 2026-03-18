import 'package:flutter/material.dart';
import 'package:myhabits/Core/animation_restart_mixin.dart';
import 'package:myhabits/Core/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myhabits/Models/QuestionModel.dart';
import 'package:myhabits/cubit/Gamecubit/game_cubit.dart';
import 'package:myhabits/cubit/Gamecubit/game_state.dart';

class LevelThreeBordersPuzzle extends StatefulWidget {
  final QuestionModel question;

  const LevelThreeBordersPuzzle({super.key, required this.question});

  @override
  State<LevelThreeBordersPuzzle> createState() =>
      _LevelThreeBordersPuzzleState();
}

class _LevelThreeBordersPuzzleState extends State<LevelThreeBordersPuzzle> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        return GameScreen(
          hint: widget.question.hint,
          color: widget.question.color,
          background: widget.question.background,
          mediaQueryRight: 0,
          mediaQueryTop: 0,
          child: Container(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.question.options.map((option) {
                    return GameButtonThree(
                      text: option,
                      onPressed: () {
                        // final cubit = context.read<GameCubit>();

                        if (option == widget.question.correctAnswer) {
                          onCorrect(context);
                        } else {
                          // restartAllAnimations();

                          onWrong(context);
                        }
                      },
                      fromWidth: 500,
                      fromHeight: 500,
                      fontSize: 35,
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
