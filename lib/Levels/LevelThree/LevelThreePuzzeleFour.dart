import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mystoria/Core/Images&colors.dart';
import 'package:mystoria/Core/animation_restart_mixin.dart';
import 'package:mystoria/Core/constants.dart';
import 'package:mystoria/Core/soundManger.dart';
import 'package:mystoria/Models/QuestionModel.dart';
import 'package:mystoria/Screens/feedackScreen.dart';
import 'package:mystoria/cubit/Gamecubit/game_cubit.dart';

class LevelThreePuzzeleFour extends StatefulWidget {
  const LevelThreePuzzeleFour({super.key, required this.question});
  final QuestionModel question;

  @override
  State<LevelThreePuzzeleFour> createState() => _LevelThreePuzzeleFourState();
}

class _LevelThreePuzzeleFourState extends State<LevelThreePuzzeleFour> {
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
                  onTap: () {
                    setState(() {
                      userOrder = e;
                    });
                    _checkResult();
                  },
                  child: Image.asset(e, width: 600.w, height: 750.h),
                );
              }).toList(),
            ),
          ),

          // AnimatedBuilder(
          //   animation: arrowController,
          //   builder: (context, child) {
          //     final screenWidth = MediaQuery.of(context).size.width;

          //     double startX = screenWidth + 200; // يبدأ خارج الشاشة يمين
          //     double endX = 20; // عند الشخصية شمال

          //     return Container(
          //       // color: Colors.red,
          //       width: MediaQuery.sizeOf(context).width,
          //       height: 1000.h,
          //       child: Stack(
          //         children: List.generate(6, (index) {
          //           double delay = index * 0.1;

          //           // نخلي كل سهم يتأخر شوية
          //           double value = (arrowController.value - delay).clamp(
          //             0.0,
          //             1.0,
          //           );

          //           // نحسب مكان السهم
          //           double position = startX - (startX - endX) * value;

          //           // يقل شفافيته تدريجيًا
          //           double opacity = (1 - value).clamp(0.0, 1.0);

          // return
          // Positioned(
          // bottom: 220.h,
          // left: position,
          // child: Opacity(
          // opacity: opacity,
          // child: Transform.scale(
          // scale: 1 - (value * 0.3), // يصغر سنة وهو بيختفي
          // child: Image.asset(AppImages.oneArow, width: 250.w, height: 150.h),
          // ),
          // ),
          // );
          // }),
          // ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }

  String _getOpenDoorImage(String closedDoor) {
    if (closedDoor == AppImages.door1Q4L) {
      return AppImages.door1Q4LOpen;
    } else if (closedDoor == AppImages.door2Q4L) {
      return AppImages.door2Q4LOpen;
    } else if (closedDoor == AppImages.door3Q4L) {
      return AppImages.door3Q4LOpen;
    }
    return closedDoor;
  }

  void _checkResult() async {
    if (userOrder == widget.question.correctAnswer) {
      SoundManager.instance.correct();
      userOrder = "";
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
      // await arrowController.forward(from: 0);
      // arrowController.reset();

      // restartAllAnimations();

      SoundManager.instance.wrong();
      userOrder = "";
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
