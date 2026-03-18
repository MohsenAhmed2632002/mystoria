
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myhabits/Core/Images&colors.dart';
import 'package:myhabits/Core/constants.dart';
import 'package:myhabits/Models/QuestionModel.dart';
import 'package:myhabits/cubit/Gamecubit/game_cubit.dart';
import 'package:myhabits/cubit/Gamecubit/game_state.dart';

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
              width: MediaQuery.sizeOf(context).width * 0.8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // _buildDoor(0, widget.question.options[0]),
                  _buildChoices("4"),
                  _buildChoices("3"),
                  _buildChoices("2"),
                  _buildChoices("1"),
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
                        _buildDoor(index: 0, image: widget.question.options[0]),
                        _buildDoor(index: 1, image: widget.question.options[1]),
                        _buildDoor(index: 2, image: widget.question.options[3]),
                        _buildDoor(index: 3, image: widget.question.options[2]),
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

  Widget _buildDoor({required int index, required String image}) {
    return DragTarget<String>(
      onAccept: (data) {
        setState(() {
          userOrder[index] = data;
        });
        _checkResult();
      },
      builder: (context, candidateData, rejectedData) {
        return Column(
          children: [
            if (userOrder[index] != null)
              GameButtonTwo(
                text: userOrder[index]!,
                fromWidth: 250,
                fromHeight: 150,

                onPressed: () {},
                fontSize: 40,
              ),
            Image.asset(image, width: 300.w, height: 300.h),
          ],
        );
      },
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
      fromHeight: 200,
      fontSize: 40,
    );
  }

  // void _checkResult() {
  //   // if (_answered) return; // يمنع التكرار
  //   if (userOrder.length < correctOrder.length) return;

  //   // _answered = true;

  //   bool isCorrect = true;

  //   correctOrder.forEach((key, value) {
  //     if (userOrder[key] != value) {
  //       isCorrect = false;
  //     }
  //   });

  //   if (isCorrect) {
  //     onCorrect(context);
  //   } else {
  //     onWrong(context);

  //     // Future.delayed(const Duration(milliseconds: 300), () {
  //     userOrder.clear();
  //     // _answered = false;
  //     setState(() {});
  //     // });
  //   }
  // }
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
