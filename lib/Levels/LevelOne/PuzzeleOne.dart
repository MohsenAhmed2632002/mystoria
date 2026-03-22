import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myhabits/Core/Images&colors.dart';
import 'package:myhabits/Core/constants.dart';
import 'package:myhabits/Core/soundManger.dart';
import 'package:myhabits/Models/QuestionModel.dart';
import 'package:myhabits/cubit/Gamecubit/game_cubit.dart';

class PuzzleOrder extends StatefulWidget {
  final QuestionModel question;

  const PuzzleOrder({super.key, required this.question});
  @override
  State<PuzzleOrder> createState() => _PuzzleOrderViewState();
}

class _PuzzleOrderViewState extends State<PuzzleOrder> {
  final Map<int, String> correctOrder = {
    0: 'عصر الدولة الحديثة',
    1: 'عصر الدولة الوسطى',
    2: 'عصر الدولة القديمة',
  };

  final Map<int, String> userOrder = {};

  @override
  void initState() {
    SoundManager.instance.stopBgm().then((_) {
      BlocProvider.of<GameCubit>(context).initState(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GameScreen(
      color: widget.question.color,
      hint: widget.question.hint,

      background: widget.question.background,
      mediaQueryRight: MediaQuery.sizeOf(context).width * 0,
      mediaQueryTop: MediaQuery.sizeOf(context).height * 0.05,
      child: Container(
        height: MediaQuery.sizeOf(context).height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 🔹 البطاقات
            Container(
              // color: Colors.red,
              width: MediaQuery.sizeOf(context).width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildDraggableCard(correctOrder[1]!),
                  _buildDraggableCard(correctOrder[0]!),
                  _buildDraggableCard(correctOrder[2]!),
                ],
              ),
            ),
            // 🔹 الأبواب
            Container(
              // color: AppColors.mainColor,
              width: MediaQuery.sizeOf(context).width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [_buildDoor(0), _buildDoor(1), _buildDoor(2)],
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
        fromWidth: 500,
        fromHeight: 150,
        fontSize: 25,
      ),
    );
  }

  // 🚪 الباب
  Widget _buildDoor(int index) {
    return DragTarget<String>(
      onAccept: (data) {
        setState(() {
          userOrder[index] = data;
        });
        _checkResult();
      },
      builder: (context, candidateData, rejectedData) {
        return userOrder[index] != null
            ? Image.asset(
                'assets/images/open_door.png',
                width: 440.w,
                height: 610.h,
              )
            : Image.asset(
                'assets/images/door.png',
                width: 440.w,
                height: 610.h,
              );
      },
    );
  }

  // ✅ التحقق من الحل
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
      //  await Future.delayed(const Duration(seconds: 3), () {});
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
