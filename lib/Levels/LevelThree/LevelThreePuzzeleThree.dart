import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myhabits/Core/Images&colors.dart';
import 'package:myhabits/Core/animation_restart_mixin.dart';
import 'package:myhabits/Core/constants.dart';
import 'package:myhabits/Models/PlayerModel.dart';
import 'package:myhabits/Models/QuestionModel.dart';
import 'package:myhabits/cubit/Gamecubit/game_cubit.dart';
import 'package:myhabits/cubit/Gamecubit/game_state.dart';
import 'package:myhabits/cubit/Playercubit/Playercubit.dart';

class LevelThreePuzzeleThree extends StatefulWidget {
  final QuestionModel question;

  const LevelThreePuzzeleThree({super.key, required this.question});

  @override
  State<LevelThreePuzzeleThree> createState() => _LevelThreePuzzeleThreeState();
}

class _LevelThreePuzzeleThreeState extends State<LevelThreePuzzeleThree>
    with SingleTickerProviderStateMixin, RestartableAnimations {
  late AnimationController fallController;
  late Animation<double> fallAnimation;
  bool isFalling = false;
  @override
  void initState() {
    super.initState();

    fallController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    fallAnimation = Tween<double>(
      begin: 0,
      end: 600.h,
    ).animate(CurvedAnimation(parent: fallController, curve: Curves.easeIn));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          body: Stack(
            children: [
              /// الخلفية
              SizedBox.expand(
                child: Image.asset(
                  widget.question.background,
                  fit: BoxFit.fill,
                ),
              ),

              ///الحسم
              Positioned(
                top: MediaQuery.sizeOf(context).height * 0.1,
                left: 0,
                right: 0,
                child: Container(
                  height: MediaQuery.sizeOf(context).height,
                  width: MediaQuery.sizeOf(context).width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: widget.question.options.map((option) {
                          return GameButtonLight(
                            text: option,
                            onPressed: () {
                              // final cubit = context.read<GameCubit>();

                              if (option == widget.question.correctAnswer) {
                                onCorrect(context);
                              } else {
                                startFalling();
                              }
                            },
                            fromWidth: 500,
                            fromHeight: 200,
                            // fontSize: 35,
                            // fromHeight: fromHeight,
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),

              ///الامنيميشن و الشخصية
              Positioned(
                bottom: 10,
                left: 20.w,
                child: BlocBuilder<PlayerCubit, PlayerModel?>(
                  builder: (context, player) {
                    if (player == null) return const SizedBox();

                    return Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        /// 🕳️ الحفرة
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 200),
                          opacity: isFalling ? 1 : 0,
                          child: Image.asset(AppImages.hole, width: 200.w),
                        ),

                        /// 🧍‍♂️ اللاعب
                        AnimatedBuilder(
                          animation: fallAnimation,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(0, fallAnimation.value),
                              child: Opacity(
                                opacity: isFalling ? 0 : 1,
                                child: Image.asset(
                                  'assets/images/${player.avatar}.png',
                                  height: 435.h,
                                  width: 300.w,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
              SettingTryAndClueContainer(hint: widget.question.hint),
              QustionContainer(color: widget.question.color),
              StarAndTimeContainer(),
            ],
          ),
        );
      },
    );
  }

  Future<void> startFalling() async {
    setState(() {
      isFalling = true;
    });

    await fallController.forward();

    // هنا اللاعب اختفى
    await Future.delayed(const Duration(milliseconds: 300));

    fallController.reset();

    setState(() {
      isFalling = false;
    });

    onWrong(context); // يرجع السؤال
  }
}
