import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myhabits/Core/Images&colors.dart';
import 'package:myhabits/Core/animation_restart_mixin.dart';
import 'package:myhabits/Core/constants.dart';
import 'package:myhabits/Core/soundManger.dart';
import 'package:myhabits/Models/QuestionModel.dart';
import 'package:myhabits/Screens/feedackScreen.dart';
import 'package:myhabits/cubit/Gamecubit/game_cubit.dart';

class LevelThreePuzzeleFive extends StatefulWidget {
  const LevelThreePuzzeleFive({super.key, required this.question});
  final QuestionModel question;

  @override
  State<LevelThreePuzzeleFive> createState() => _LevelThreePuzzeleFiveState();
}

class _LevelThreePuzzeleFiveState extends State<LevelThreePuzzeleFive> {
  String? openedDoor;
  bool showArrows = false;
  String userOrder = "";

  @override
  Widget build(BuildContext context) {
    return GameScreen(
      hint: widget.question.hint,
      color: widget.question.color,
      background: widget.question.background,
      mediaQueryRight: 0,
      mediaQueryTop: MediaQuery.sizeOf(context).height * 0.1,
      child: Stack(
        children: [
          Container(
            // color: AppColors.mainColor,
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.question.options.map((e) {
                return GestureDetector(
                  onTap: () async {
                    setState(() {
                      userOrder = e;
                      openedDoor = e; // الباب اللي اتضغط عليه يفتح
                    });

                    await _checkResult();
                  },
                  child: Image.asset(
                    openedDoor == e ? e : _getClosedDoor(e),
                    width: 600.w,
                    height: 900.h,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  String _getClosedDoor(String openDoor) {
    if (openDoor == AppImages.openAhmoos) {
      return AppImages.ahmoos;
    } else if (openDoor == AppImages.openRamses) {
      return AppImages.ramses;
    } else if (openDoor == AppImages.openTohotmos) {
      return AppImages.tohotmos;
    }
    return openDoor;
  }

  Future<void> _checkResult() async {
    if (userOrder == widget.question.correctAnswer) {
      // userOrder.clear();
      // SoundManager.instance.effectOpenDoor();
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

      // userOrder.clear();
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

// }
