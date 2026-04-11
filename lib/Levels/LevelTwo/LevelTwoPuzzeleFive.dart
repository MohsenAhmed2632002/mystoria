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

class LevelTwoPuzzeleFive extends StatefulWidget {
  final QuestionModel question;
  const LevelTwoPuzzeleFive({super.key, required this.question});

  @override
  State<LevelTwoPuzzeleFive> createState() => _LevelTwoPuzzeleFiveState();
}

class _LevelTwoPuzzeleFiveState extends State<LevelTwoPuzzeleFive>
    with SingleTickerProviderStateMixin, RestartableAnimations {
  late AnimationController controller;
  late Animation<double> moveAnimationRight;
  late Animation<double> moveAnimationLeft;
  String balanceImage = AppImages.balance;
  bool locked = false;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    registerController(controller);

    moveAnimationRight = Tween<double>(
      begin: 0,
      end: -60,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

    moveAnimationLeft = Tween<double>(
      begin: 0,
      end: -60,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
  }

  String userOrder = "";

  @override
  Widget build(BuildContext context) {
    return GameScreen(
      color: widget.question.color,
      hint: widget.question.hint,

      background: widget.question.background,
      mediaQueryRight: 0,
      mediaQueryTop: MediaQuery.sizeOf(context).height * 0.1,
      child: Container(
        height: MediaQuery.sizeOf(context).height * 0.9,
        width: MediaQuery.sizeOf(context).width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: widget.question.options.map((option) {
            return GameButtonThree(
              text: option,
              onPressed: () {
                // if (freezGame) return;

                // ✅ الإجابة الصحيحة
                if (option == widget.question.correctAnswer) {
                  SoundManager.instance.correct();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FeedackScreen(
                        isCorrect: true,
                        stars: BlocProvider.of<GameCubit>(
                          context,
                        ).calculateStars(),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FeedackScreen(
                        isCorrect: false,
                        stars: 0,
                        attempts:
                            BlocProvider.of<GameCubit>(
                              context,
                            ).state.theGame.attempts -
                            1,
                        timeLeft: BlocProvider.of<GameCubit>(
                          context,
                        ).state.theGame.timeLeft,
                      ),
                    ),
                  );
                }
              },
              fontSize: 30,
              fromWidth: 450,
              fromHeight: 650,
            );
          }).toList(),
        ),
      ),
    );
  }

  void _checkResult() async {
    if (userOrder == widget.question.correctAnswer) {
      balanceImage = AppImages.balance2;

      await controller.forward(from: 0);

      SoundManager.instance.iron();
      moveAnimationLeft = Tween<double>(begin: 0, end: 60).animate(controller);
      controller.reverse().then(
        (value) => setState(() {
          balanceImage = AppImages.balance;
        }),
      );
      onCorrect(context);
    } else {
      balanceImage = AppImages.balance1;

      moveAnimationRight = Tween<double>(begin: 0, end: 60).animate(controller);

      await controller.forward(from: 0);

      SoundManager.instance.ironFall();
      restartAllAnimations();

      onWrong(context);

      controller.reverse().then(
        (value) => setState(() {
          balanceImage = AppImages.balance;
        }),
      );
    }
  }
}
