import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myhabits/Core/constants.dart';
import 'package:myhabits/Core/soundManger.dart';
import 'package:myhabits/Models/QuestionModel.dart';
import 'package:myhabits/Screens/feedackScreen.dart';
import 'package:myhabits/cubit/Gamecubit/game_cubit.dart';

class LevelThreePuzzeleEleven extends StatefulWidget {
  final QuestionModel question;

  const LevelThreePuzzeleEleven({super.key, required this.question});

  @override
  State<LevelThreePuzzeleEleven> createState() =>
      _LevelThreePuzzeleElevenState();
}

class _LevelThreePuzzeleElevenState extends State<LevelThreePuzzeleEleven> {
  final Map<int, String> userOrder = {};

  @override
  Widget build(BuildContext context) {
    return GameScreen(
      color: widget.question.color,
      hint: widget.question.hint,

      background: widget.question.background,
      mediaQueryRight: MediaQuery.sizeOf(context).width * 0,
      mediaQueryTop: MediaQuery.sizeOf(context).height * 0.2,
      child: Container(
        // color: Colors.white38,
        height: MediaQuery.sizeOf(context).height * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // 🔹 البطاقات
            Container(
              // color: Colors.red,
              width: MediaQuery.sizeOf(context).width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildDraggableCard('4'),
                  _buildDraggableCard("3"),
                  _buildDraggableCard("2"),
                  _buildDraggableCard("1"),
                ],
              ),
            ),

            //the doors
            Container(
              // color: Colors.red,
              width: MediaQuery.sizeOf(context).width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    widget.question.options[1],
                    width: 350.w,
                    height: 500.h,
                  ),
                  Image.asset(
                    widget.question.options[0],
                    width: 350.w,
                    height: 500.h,
                  ),
                  Image.asset(
                    widget.question.options[3],
                    width: 350.w,
                    height: 500.h,
                  ),
                  Image.asset(
                    widget.question.options[2],
                    width: 350.w,
                    height: 500.h,
                  ),
                ],
              ),
            ),
            // الاجابات
            Container(
              // color: AppColors.mainColor,
              width: MediaQuery.sizeOf(context).width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _placeOfAnswers(0),
                  _placeOfAnswers(1),
                  _placeOfAnswers(2),
                  _placeOfAnswers(3),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🟦 البطاقة
  Widget _buildDraggableCard(String era) {
    return Draggable<String>(
      data: era,
      childWhenDragging: _card(era, faded: true),
      // السحب
      feedback: _card(era, dragging: true),
      child: _card(era),
    );
  }

  Widget _card(String text, {bool dragging = false, bool faded = false}) {
    return Opacity(
      opacity: faded ? 0.3 : 1,
      child: GameButtonTwo(
        text: text,
        onPressed: () {},
        fromWidth: 300,
        fromHeight: 125,
        fontSize: 100.sp,
      ),
    );
  }

  // 🚪 الباب
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
                fontSize: 90.sp,
              )
            : Image.asset(
                'assets/images/button_game.png',
                width: 300.w,
                height: 125.h,
              );
      },
    );
  }

  // ✅ التحقق من الحل
  void _checkResult() async {
    if (userOrder.length < 4) return;

    bool isCorrect = true;
    widget.question.correctAnswer.forEach((key, value) {
      if (userOrder[key] != value) {
        isCorrect = false;
      }
    });

    if (isCorrect) {
      userOrder.clear();
      SoundManager.instance.correct();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => FeedackScreen(
            isCorrect: true,
            stars: BlocProvider.of<GameCubit>(context).calculateStars(),
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
      setState(() {});
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => FeedackScreen(
            isCorrect: false,
            stars: 0,
            attempts:
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
