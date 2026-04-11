import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myhabits/Core/Images&colors.dart';
import 'package:myhabits/Core/constants.dart';
import 'package:myhabits/Core/soundManger.dart';
import 'package:myhabits/Models/QuestionModel.dart';
import 'package:myhabits/Screens/feedackScreen.dart';
import 'package:myhabits/cubit/Gamecubit/game_cubit.dart';

class PuzzeleCemeteries extends StatefulWidget {
  final QuestionModel question;

  const PuzzeleCemeteries({super.key, required this.question});

  @override
  State<PuzzeleCemeteries> createState() => _PuzzeleCemeteriesState();
}

class _PuzzeleCemeteriesState extends State<PuzzeleCemeteries> {
  final Map<int, String> userOrder = {};
  final Map<int, String> correctOrder = {0: "1", 2: "2", 1: "3", 3: "4"};

  @override
  Widget build(BuildContext context) {
    return GameScreen(
      hint: widget.question.hint,
      color: widget.question.color,
      background: widget.question.background,
      mediaQueryRight: 0,
      mediaQueryTop: MediaQuery.sizeOf(context).height * 0.1,

      child: Container(
        // color: Colors.red,
        height: MediaQuery.sizeOf(context).height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              // color: Colors.red,
              width: MediaQuery.sizeOf(context).width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildChoices("4"),
                  _buildChoices("3"),
                  _buildChoices("2"),
                  _buildChoices("1"),
                ],
              ),
            ),
            Container(
              // color: AppColors.mainColor,
              width: MediaQuery.sizeOf(context).width,
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildDoor(image: widget.question.options[0]),
                  _buildDoor(image: widget.question.options[1]),
                  _buildDoor(image: widget.question.options[3]),
                  _buildDoor(image: widget.question.options[2]),
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
                fontSize: 100.sp,
              )
            : Image.asset(
                'assets/images/button_game.png',
                width: 300.w,
                height: 125.h,
              );
      },
    );
  }

  Widget _buildDoor({required String image}) {
    return Image.asset(image, width: 300.w, height: 300.h);
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
