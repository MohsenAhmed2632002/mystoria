import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myhabits/Core/Images&colors.dart';
import 'package:myhabits/Core/constants.dart';
import 'package:myhabits/Core/soundManger.dart';
import 'package:myhabits/Models/QuestionModel.dart';
import 'package:myhabits/Screens/feedackScreen.dart';
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
      mediaQueryTop: 0,
      child: Container(
        // color: Colors.amberAccent,
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height * 0.9,

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: widget.question.options.map((option) {
            return GameButtonTwo(
              fromHeight: 135,
              fromWidth: 350,
              text: option,
              onPressed: () {
                if (option == widget.question.correctAnswer) {
                  // ✅ صح
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
    0: 'اوسر كاف',
    1: 'سنفرو ',
    2: 'اوناس ',
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
        height: MediaQuery.sizeOf(context).height * 0.9,
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              // color: Colors.red,
              width: MediaQuery.sizeOf(context).width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildChoices(widget.question.options[1]),
                  _buildChoices(widget.question.options[2]),
                  _buildChoices(widget.question.options[0]),
                ],
              ),
            ),
            Container(
              width: MediaQuery.sizeOf(context).width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildDoor(AppImages.maabadElshams),
                  _buildDoor(AppImages.haramModarag),
                  _buildDoor(AppImages.ketabatHaet),
                ],
              ),
            ),
            Container(
              // color: AppColors.mainColor,
              width: MediaQuery.sizeOf(context).width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _placeOfAnswers(0),
                  _placeOfAnswers(1),
                  _placeOfAnswers(2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _placeOfAnswers(int index) {
    return DragTarget<String>(
      onAccept: (data) {
        setState(() {
          userOrder[index] = data;
        });
        _checkResult();
      },
      builder: (context, candidateData, rejectedData) {
        return userOrder[index] != null
            ? GameButtonTwo(
                text: userOrder[index]!,
                onPressed: () {},
                fromWidth: 300,
                fromHeight: 125,
                fontSize: 25,
              )
            : Image.asset(
                'assets/images/button_game.png',
                width: 300.w,
                height: 125.h,
              );
      },
    );
  }

  Widget _buildDoor(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [Image.asset(text, width: 600.w, height: 550.h)],
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
      fromWidth: 300,
      fromHeight: 125,
      fontSize: 70.sp,
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
      SoundManager.instance.correct();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => FeedackScreen(
            isCorrect: true,
            stars: BlocProvider.of<GameCubit>(context).calculateStars(),
            helps: BlocProvider.of<GameCubit>(context).state.theGame.attempts,
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
                BlocProvider.of<GameCubit>(context).state.theGame.attempts - 1,
            timeLeft: BlocProvider.of<GameCubit>(
              context,
            ).state.theGame.timeLeft,
          ),
        ),
      );
    }
  }
}
