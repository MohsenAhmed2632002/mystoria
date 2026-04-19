import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mystoria/Core/animation_restart_mixin.dart';
import 'package:mystoria/Core/constants.dart';
import 'package:mystoria/Core/soundManger.dart';
import 'package:mystoria/Models/QuestionModel.dart';
import 'package:mystoria/Screens/feedackScreen.dart';
import 'package:mystoria/cubit/Gamecubit/game_cubit.dart';
import 'package:mystoria/cubit/Gamecubit/game_state.dart';

class LevelTwoPuzzeleThree extends StatefulWidget {
  final QuestionModel question;

  const LevelTwoPuzzeleThree({super.key, required this.question});

  @override
  State<LevelTwoPuzzeleThree> createState() => _LevelTwoPuzzeleThreeState();
}

class _LevelTwoPuzzeleThreeState extends State<LevelTwoPuzzeleThree> {
  // with SingleTickerProviderStateMixin, RestartableAnimations {
  // late AnimationController controller;
  // late Animation<double> animation;

  // @override
  // void initState() {
  //   super.initState();

  //   controller = AnimationController(
  //     vsync: this,
  //     duration: const Duration(seconds: 6),
  //   );
  //   registerController(controller);
  //   animation = Tween<double>(
  //     begin: -1, // خارج الشاشة من الشمال
  //     end: 1.2, // خارج الشاشة من اليمين
  //   ).animate(CurvedAnimation(parent: controller, curve: Curves.linear));

  //   // _startAnimation();
  // }

  // Future<void> _startAnimation() async {
  //   await controller.animateTo(0.5, duration: const Duration(seconds: 2));

  //   // توقف في المنتصف
  //   await Future.delayed(const Duration(seconds: 3));

  //   // يكمل الحركة
  //   await controller.animateTo(1, duration: const Duration(seconds: 2));
  // }

  // @override
  // void dispose() {
  //   controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // return BlocBuilder<GameCubit, GameState>(
    // builder: (context, state) {
    // if (context.read<GameCubit>().state.theGame.timeLeft == 30) {
    // _startAnimation();
    // }
    return GameScreen(
      hint: widget.question.hint,
      color: widget.question.color,
      background: widget.question.background,
      mediaQueryRight: 0,
      mediaQueryTop: 0,
      child: Stack(
        children: [
          Container(
            // color: Colors.red,
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: widget.question.options.map((option) {
                    return GameButtonThree(
                      text: option,
                      onPressed: () {
                        // final cubit = context.read<GameCubit>();

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
                          // userOrder.clear();
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
                      fromWidth: 450,
                      fromHeight: 650,
                      fontSize: 35,
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          // AnimatedBuilder(
          //   animation: animation,
          //   child: SizedBox(
          //     child: Image.asset(
          //       "assets/images/fog.png",
          //       width: MediaQuery.sizeOf(context).width,
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          //   builder: (context, child) {
          //     return Positioned(
          //       child: child!,
          //       left: animation.value * MediaQuery.sizeOf(context).width,
          //     );
          //   },
          // ),
        ],
      ),
      // );
      // },
    );
  }
}
