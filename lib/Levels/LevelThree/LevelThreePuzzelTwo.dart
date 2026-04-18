import 'dart:async';
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

class LevelThreePuzzeleTwo extends StatefulWidget {
  final QuestionModel question;

  const LevelThreePuzzeleTwo({super.key, required this.question});

  @override
  State<LevelThreePuzzeleTwo> createState() => _LevelThreePuzzeleTwoState();
}

class _LevelThreePuzzeleTwoState extends State<LevelThreePuzzeleTwo> {
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
        height: MediaQuery.sizeOf(context).height * 0.9,
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildChoicesContainer(widget.question.options[2]),
                _buildChoicesContainer(widget.question.options[0]),
                _buildChoicesContainer(widget.question.options[1]),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 🚪 الباب
  Widget _buildChoicesContainer(String image) {
    return GestureDetector(
      onTap: () => _checkResult(image),

      child: Image.asset(image, width: 500.w, height: 800.h),
    );
  }

  // ✅ التحقق من الحل
  void _checkResult(String selectedImage) async {
    if (selectedImage == widget.question.correctAnswer) {
      // SoundManager.instance.wind();

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

      setState(() {});
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
