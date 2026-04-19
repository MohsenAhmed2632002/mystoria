import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mystoria/Core/Images&colors.dart';
import 'package:mystoria/Core/constants.dart';
import 'package:mystoria/Core/soundManger.dart';
import 'package:mystoria/Models/QuestionModel.dart';
import 'package:mystoria/Screens/feedackScreen.dart';
import 'package:mystoria/cubit/Gamecubit/game_cubit.dart';

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
    super.initState();
    BlocProvider.of<GameCubit>(context).initState(context);
  }

  @override
  Widget build(BuildContext context) {
    return GameScreen(
      color: widget.question.color,
      hint: widget.question.hint,

      background: widget.question.background,
      mediaQueryRight: MediaQuery.sizeOf(context).width * 0,
      mediaQueryTop: MediaQuery.sizeOf(context).height * 0.12,
      child: Container(
        // color: Colors.white38,
        height: MediaQuery.sizeOf(context).height * 0.9,
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
                  _buildDraggableCard(correctOrder[1]!),
                  _buildDraggableCard(correctOrder[2]!),
                  _buildDraggableCard(correctOrder[0]!),
                ],
              ),
            ),

            //the doors
            Container(
              // color: Colors.red,
              width: MediaQuery.sizeOf(context).width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppImages.door_2L1, width: 550.w, height: 600.h),
                  Image.asset(AppImages.door_3L1, width: 550.w, height: 600.h),
                  Image.asset(AppImages.door_1L1, width: 550.w, height: 600.h),
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
        fromWidth: 350,
        fromHeight: 120,
        fontSize: 50.sp,
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
                fromWidth: 350,
                fromHeight: 125,
                fontSize: 50.sp,
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
                // child: Center(
                //   child: Text(
                //     text,
                //     style: getBoldTextStyle(
                //       fontSize: fontSize.sp,
                //       context: context,
                //       color: Colors.black,
                //     ),
                //   ),
                // ),
              );
        // Image.asset(
        //     'assets/images/button_game.png',
        //     width: 350.w,
        //     height: 125.h,
        //   );
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
      // setState(() {});
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
