import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myhabits/Core/Images&colors.dart';
import 'package:myhabits/Core/constants.dart';
import 'package:myhabits/Models/QuestionModel.dart';
import 'package:myhabits/cubit/Gamecubit/game_cubit.dart';
import 'package:myhabits/cubit/Gamecubit/game_state.dart';

class PuzzleCrown extends StatefulWidget {
  final QuestionModel question;
  const PuzzleCrown({super.key, required this.question});

  @override
  State<PuzzleCrown> createState() => _PuzzleCrownState();
}

class _PuzzleCrownState extends State<PuzzleCrown> {
  final Map<int, String> userOrder = {};
  final Map<int, String> correctOrder = {
    0: AppImages.crownzosar,
    1: AppImages.crownsenfro,
    2: AppImages.crownkhofo,
  };
  @override
  Widget build(BuildContext context) {
    return GameScreen(
      color: widget.question.color,
      hint: widget.question.hint,

      background: AppImages.quiz4,
      mediaQueryRight: 0,
      mediaQueryTop: MediaQuery.sizeOf(context).height * 0.1,
      child: Container(
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
                    // color: AppColors.mainColor,
                    width: MediaQuery.sizeOf(context).width,
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildDoor(2, AppImages.chairwithbigpyramid),
                        _buildDoor(1, AppImages.chairShip),
                        _buildDoor(0, AppImages.chairSteppedPyramid),
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

  Widget _buildDoor(int index, String image) {
    return DragTarget<String>(
      onAccept: (data) {
        setState(() {
          userOrder[index] = data;
        });
        _checkResult();
      },
      builder: (context, _, __) {
        return Column(
          children: [
            if (userOrder[index] != null)
              Image.asset(userOrder[index]!, width: 250.w, height: 150.h),
            Image.asset(image, width: 440.w, height: 600.h),
          ],
        );
      },
    );
  }

  Widget _buildChoices(String image) {
    return Draggable<String>(
      data: image,
      feedback: _choiceCard(image),
      childWhenDragging: Opacity(opacity: 0.4, child: _choiceCard(image)),
      child: _choiceCard(image),
    );
  }

  Widget _choiceCard(String image) {
    return Container(
      width: 250.w,
      height: 250.h,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(image)),
      ),
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
      onCorrect(context);
      // cubit.correctAnswer(context);
    } else {
      onWrong(context);
      userOrder.clear();
      setState(() {});
    }
  }
}
