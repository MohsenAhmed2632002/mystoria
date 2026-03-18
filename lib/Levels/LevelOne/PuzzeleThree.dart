import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myhabits/Core/constants.dart';
import 'package:myhabits/Models/QuestionModel.dart';
import 'package:myhabits/cubit/Gamecubit/game_cubit.dart';
import 'package:myhabits/cubit/Gamecubit/game_state.dart';

class ChooseWidget extends StatefulWidget {
  final QuestionModel question;
  const ChooseWidget({super.key, required this.question});

  @override
  State<ChooseWidget> createState() => _ChooseWidgetWidgetState();
}

class _ChooseWidgetWidgetState extends State<ChooseWidget> {
  @override
  Widget build(BuildContext context) {
    return GameScreen(
      color: widget.question.color,
      hint: widget.question.hint,

      background: widget.question.background,
      mediaQueryRight: 0,
      mediaQueryTop: MediaQuery.sizeOf(context).height * 0.2,
      child: Container(
        // color: Colors.amberAccent,
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.question.options.map((option) {
            return GameButtonTwo(
              fromHeight: 200,
              fromWidth: 500,
              text: option,
              onPressed: () {

                if (option == widget.question.correctAnswer) {
                  // ✅ صح
                  onCorrect(context);
                } else {
                  onWrong(context);
                }
              },
              fontSize: 35,
            );
          }).toList(),
        ),
      ),
    );
  }
}

class ChooseHWidget extends StatefulWidget {
  final QuestionModel question;
  const ChooseHWidget({super.key, required this.question});

  @override
  State<ChooseHWidget> createState() => _ChooseHWidgettWidgetState();
}

class _ChooseHWidgettWidgetState extends State<ChooseHWidget> {
  final Map<int, String> correctOrder = {
    0: "شيد معابد الشمس",
    1: " اول هرم كامل ",
    2: "كتب نصوص الاهرام علي الجدران",
  };

  final Map<int, String> userOrder = {};

  @override
  Widget build(BuildContext context) {
    return GameScreen(
      color: widget.question.color,
      hint: widget.question.hint,

      background: widget.question.background,
      mediaQueryRight: 0,
      mediaQueryTop: MediaQuery.sizeOf(context).height * 0.1,
      child: Container(
        // color: AppColors.mainColor,
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              // color: Colors.red,
              width: MediaQuery.sizeOf(context).width * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildChoices(correctOrder[1]!),
                  _buildChoices(correctOrder[2]!),
                  _buildChoices(correctOrder[0]!),
                ],
              ),
            ),

            BlocBuilder<GameCubit, GameState>(
              builder: (context, state) {
                if (state is GamePlaying) {
                  return Container(
                    // color: AppColors.m  ainColor,
                    width: MediaQuery.sizeOf(context).width * 0.6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildDoor(0, "اوسركاف"),
                        _buildDoor(1, "سنفرو"),
                        _buildDoor(2, 'اوناس '),
                      ],
                    ),
                  );
                } else {
                  return Text("No Data");
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDoor(int index, String text) {
    return DragTarget<String>(
      onAccept: (data) {
        setState(() {
          userOrder[index] = data;
        });
        _checkResult();
      },
      builder: (context, _, __) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (userOrder[index] != null)
              GameButtonTwo(
                text: userOrder[index]!,

                onPressed: () {},
                fromWidth: 550,
                fromHeight: 280,
                fontSize: 25,
              ),
            GameButtonTwo(
              text: text,
              onPressed: () {},
              fromWidth: 550,
              fromHeight: 280,
              fontSize: 25,
            ), // Image.asset(userOrder[index]!, width: 250.w, height: 150.h),
            // Image.asset(image, width: 440.w, height: 600.h),
          ],
        );
      },
    );
  }

  Widget _buildChoices(String text) {
    return Draggable<String>(
      data: text,
      feedback: _choiceCard(text),
      childWhenDragging: Opacity(opacity: 0.4, child: _choiceCard(text)),
      child: _choiceCard(text),
    );
  }

  Widget _choiceCard(String text) {
    return GameButtonTwo(
      text: text,
      onPressed: () {},
      fromWidth: 580,
      fromHeight: 280,
      fontSize: 25,
    );
  }

  void _checkResult() async {
    if (userOrder.length < 3) return;

    bool isCorrect = true;
    correctOrder.forEach((key, value) {
      if (userOrder[key] != value) {
        isCorrect = false;
      }
    });

    if (isCorrect) {
      onCorrect(context);
      // await SoundManager.playCorrect();
      // context.read<GameCubit>().correctAnswer(context);
      // _showResultDialog(true);
    } else {
      // await SoundManager.playWrong();
      // context.read<GameCubit>().wrongAnswer(context);
      onWrong(context);
      userOrder.clear();
      setState(() {});
    }
  }
}
