import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mystoria/Core/Images&colors.dart';
import 'package:mystoria/Core/animation_restart_mixin.dart';
import 'package:mystoria/Core/constants.dart';
import 'package:mystoria/Core/soundManger.dart';
import 'package:mystoria/Models/PlayerModel.dart';
import 'package:mystoria/Models/QuestionModel.dart';
import 'package:mystoria/Screens/feedackScreen.dart';
import 'package:mystoria/cubit/Gamecubit/game_cubit.dart';
import 'package:mystoria/cubit/Playercubit/Playercubit.dart';

class LevelTwoPuzzeleBoat extends StatefulWidget {
  final QuestionModel question;
  const LevelTwoPuzzeleBoat({super.key, required this.question});

  @override
  State<LevelTwoPuzzeleBoat> createState() => _LevelTwoPuzzeleBoatState();
}

class _LevelTwoPuzzeleBoatState extends State<LevelTwoPuzzeleBoat>
    with SingleTickerProviderStateMixin, RestartableAnimations {
  final Map<int, String> userOrder = {};
  final Map<int, String> correctOrder = {0: "2", 1: "4", 2: "3", 3: "1"};
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
                fromWidth: 350,
                fromHeight: 125,
                fontSize: 50,
              )
            : Container(
                width: 350.w,
                height: 125.h,

                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(AppImages.buttongame),
                  ),
                ),
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildChoices("4"),
                  _buildChoices("3"),
                  _buildChoices("2"),
                  _buildChoices("1"),
                ],
              ),
            ),

            //the doors
            Container(
              // color: Colors.red,
              width: MediaQuery.sizeOf(context).width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
      fromWidth: 350,
      fromHeight: 125,
      fontSize: 100.sp,
    );
  }
}
