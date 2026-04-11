import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:myhabits/Core/Font.dart';
import 'package:myhabits/Core/Images&colors.dart';
import 'package:myhabits/Core/constants.dart';
import 'package:myhabits/Core/soundManger.dart';
import 'package:myhabits/Models/QuestionModel.dart';
import 'package:myhabits/Screens/feedackScreen.dart';
import 'package:myhabits/cubit/Gamecubit/game_cubit.dart';

class TheDoorQuestion extends StatefulWidget {
  final QuestionModel question;
  const TheDoorQuestion({super.key, required this.question});

  @override
  State<TheDoorQuestion> createState() => _TheDoorQuestionState();
}

class _TheDoorQuestionState extends State<TheDoorQuestion> {
  bool answered = false;

  @override
  Widget build(BuildContext context) {
    return GameScreen(
      color: widget.question.color,
      background: widget.question.background,
      mediaQueryRight: 0,
      mediaQueryTop: MediaQuery.sizeOf(context).height * 0.1,
      hint: widget.question.hint,
      child: Container(
        // color: Colors.cyan,
        height: MediaQuery.sizeOf(context).height * 0.9,
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            answered
                ? Image.asset(
                    AppImages.bigDoorOpen,
                    width: 800.w,
                    height: 750.h,
                  )
                : Image.asset(
                    AppImages.bigDoorClose,
                    width: 800.w,
                    height: 750.h,
                  ),

            /// 🔹 Targets (الأبواب)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                widget.question.options.length,
                (index) => _buildDoor(widget.question.options[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDoor(String familyText) {
    return GameButtonTwo(
      text: familyText,
      onPressed: () => _checkAnswer(familyText),
      fontSize: 40,
      fromWidth: 350,
      fromHeight: 125,
    );
  }

  void _checkAnswer(String theAnwser) async {
    if (theAnwser == widget.question.correctAnswer) {
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
            attempts: BlocProvider.of<GameCubit>(context).state.theGame.attempts-1,
            timeLeft: BlocProvider.of<GameCubit>(
              context,
            ).state.theGame.timeLeft,
          ),
        ),
      );
    }
    // }
  }
}
