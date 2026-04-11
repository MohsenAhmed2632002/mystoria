import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myhabits/Core/Images&colors.dart';
import 'package:myhabits/Core/constants.dart';
import 'package:myhabits/Core/soundManger.dart';
import 'package:myhabits/Models/QuestionModel.dart';
import 'package:myhabits/Screens/feedackScreen.dart';
import 'package:myhabits/cubit/Gamecubit/game_cubit.dart';

class PuzzleCrown extends StatefulWidget {
  final QuestionModel question;
  const PuzzleCrown({super.key, required this.question});

  @override
  State<PuzzleCrown> createState() => _PuzzleCrownState();
}

class _PuzzleCrownState extends State<PuzzleCrown> {
  final Map<int, String> userOrder = {};
  final Map<int, String> correctOrder = {2: "زوسر", 1: "سنفرو", 0: "خوفو"};
  @override
  Widget build(BuildContext context) {
    return GameScreen(
      color: widget.question.color,
      hint: widget.question.hint,
      background: widget.question.background,
      mediaQueryRight: 0,
      mediaQueryTop: MediaQuery.sizeOf(context).height * 0.11,
      child: Container(
        // color: Colors.red,
        height: MediaQuery.sizeOf(context).height * 0.9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildDraggableCard(correctOrder[1]!),
                  _buildDraggableCard(correctOrder[2]!),
                  _buildDraggableCard(correctOrder[0]!),
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
                  _buildDoor(AppImages.chairwithbigpyramid),
                  _buildDoor(AppImages.chairShip),
                  _buildDoor(AppImages.chairSteppedPyramid),
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
        fontSize: 50.sp,
      ),
    );
  }

  Widget _buildDoor(String image) {
    return Image.asset(image, width: 500.w, height: 600.h);
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

            // Container(
            //   // color: Colors.red,
            //   width: MediaQuery.sizeOf(context).width,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //       _buildChoices(correctOrder[1]!),
            //       _buildChoices(correctOrder[2]!),
            //       _buildChoices(correctOrder[0]!),
            //     ],
            //   ),
            // ),

  // Widget _buildChoices(String image) {
  //   return Draggable<String>(
  //     data: image,
  //     feedback: _choiceCard(image),
  //     childWhenDragging: Opacity(opacity: 0.4, child: _choiceCard(image)),
  //     child: _choiceCard(image),
  //   );
  // }

  // Widget _choiceCard(String image) {
  //   return Container(
  //     width: 250.w,
  //     height: 250.h,
  //     decoration: BoxDecoration(
  //       image: DecorationImage(image: AssetImage(image)),
  //     ),
  //   );
  // }