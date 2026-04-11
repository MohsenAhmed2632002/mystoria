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
import 'package:myhabits/cubit/Gamecubit/game_state.dart';

class LevelTwoPuzzeleSix extends StatefulWidget {
  const LevelTwoPuzzeleSix({super.key, required this.question});
  final QuestionModel question;
  @override
  State<LevelTwoPuzzeleSix> createState() => _LevelTwoPuzzeleSixViewState();
}

class _LevelTwoPuzzeleSixViewState extends State<LevelTwoPuzzeleSix> {
  final Map<int, String> userOrder = {};
  final Map<int, String> correctOrder = {0: "4", 1: "3", 2: "1", 3: "2"};
  //1234

  void _checkResult() {
    if (userOrder.length < correctOrder.length) return;

    bool isCorrect = true;

    for (int i = 0; i < correctOrder.length; i++) {
      if (userOrder[i] != correctOrder[i]) {
        isCorrect = false;
        break;
      }
    }

    // final cubit = context.read<GameCubit>();

    if (isCorrect) {
      SoundManager.instance.correct();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => FeedackScreen(
            isCorrect: true,
            stars: BlocProvider.of<GameCubit>(context).calculateStars(),
            attempts: BlocProvider.of<GameCubit>(context).state.theGame.attempts,
            timeLeft: BlocProvider.of<GameCubit>(
              context,
            ).state.theGame.timeLeft,
          ),
        ),
      );
    } else {
      SoundManager.instance.wrong();
      userOrder.clear();
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

  @override
  Widget build(BuildContext context) {
    return GameScreen(
      mediaQueryRight: 0,
      mediaQueryTop:
          //  0,
          MediaQuery.sizeOf(context).height * 0.1,
      hint: widget.question.hint,
      color: widget.question.color,
      background: widget.question.background,
      child: Container(
        // color: AppColors.backgroundColor,
        height: MediaQuery.sizeOf(context).height * 0.9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              // color: Colors.red,
              width: MediaQuery.sizeOf(context).width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildChoices("1"),
                  _buildChoices("3"),
                  _buildChoices("4"),
                  _buildChoices("2"),
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
                    widget.question.options[0],
                    width: 450.w,
                    height: 300.h,
                  ),
                  Image.asset(
                    widget.question.options[2],
                    width: 450.w,
                    height: 300.h,
                  ),
                  Image.asset(
                    widget.question.options[1],
                    width: 450.w,
                    height: 300.h,
                  ),
                  Image.asset(
                    widget.question.options[3],
                    width: 450.w,
                    height: 300.h,
                  ),
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
                  _placeOfAnswers(3),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChoices(String myNum) {
    return Draggable<String>(
      data: myNum,
      feedback: _choiceCard(myNum),
      childWhenDragging: Opacity(opacity: 0.4, child: _choiceCard(myNum)),
      child: _choiceCard(myNum),
    );
  }

  Widget _choiceCard(String myNum) {
    return GameButtonTwo(
      text: myNum,
      onPressed: () {},
      fromWidth: 300,
      fromHeight: 125,
      fontSize: 100.sp,
    );
  }
}
