import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:mystoria/Core/Font.dart';
import 'package:mystoria/Core/Images&colors.dart';
import 'package:mystoria/Core/constants.dart';
import 'package:mystoria/Core/soundManger.dart';
import 'package:mystoria/Models/QuestionModel.dart';
import 'package:mystoria/Screens/feedackScreen.dart';
import 'package:mystoria/cubit/Gamecubit/game_cubit.dart';

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
            Image.asset(AppImages.bigDoorClose, width: 800.w, height: 750.h),

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
      fontSize: 100.sp,
      fromWidth: 350,
      fromHeight: 125,
    );
  }

  void _checkAnswer(String theAnwser) async {
    
    if (theAnwser == widget.question.correctAnswer) {
      SoundManager.instance.correct();
        SoundManager.instance.click();

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
        SoundManager.instance.click();

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
    // }
  }
}
