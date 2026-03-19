import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myhabits/Core/Font.dart';
import 'package:myhabits/Core/Images&colors.dart';
import 'package:myhabits/Core/animation_restart_mixin.dart';
import 'package:myhabits/Core/constants.dart';
import 'package:myhabits/Core/soundManger.dart';
import 'package:myhabits/Models/PlayerModel.dart';
import 'package:myhabits/Models/QuestionModel.dart';
import 'package:myhabits/cubit/Gamecubit/game_cubit.dart';
import 'package:myhabits/cubit/Playercubit/Playercubit.dart';

class LevelThreePuzzeleOne extends StatefulWidget {
  final QuestionModel question;

  const LevelThreePuzzeleOne({super.key, required this.question});
  @override
  State<LevelThreePuzzeleOne> createState() => _LevelThreePuzzeleOneViewState();
}

class _LevelThreePuzzeleOneViewState extends State<LevelThreePuzzeleOne>
    with TickerProviderStateMixin, RestartableAnimations {
  bool answered = false;
  late AnimationController stonesController;
  late Animation<double> stonesDrop;

  bool showStones = false;
  final List<String> userOrder = [];

  @override
  void initState() {
    SoundManager.instance.stopBgm().then((_) {
      BlocProvider.of<GameCubit>(context).initState(context);
    });
    stonesController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    registerController(stonesController);

    stonesDrop = Tween<double>(
      begin: -1,
      end: 0,
    ).animate(CurvedAnimation(parent: stonesController, curve: Curves.easeIn));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          /// الخلفية
          SizedBox.expand(
            child: Image.asset(widget.question.background, fit: BoxFit.fill),
          ),

          ///الجسم
          Positioned(
            top: MediaQuery.sizeOf(context).height * 0.1,
            left: 0,
            right: 0,
            child: Container(
              // color: Colors.cyan,
              height: MediaQuery.sizeOf(context).height * 1,
              width: MediaQuery.sizeOf(context).width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  answered
                      ? Image.asset(
                          AppImages.openDoor_3,
                          width: 700.w,
                          height: 700.h,
                        )
                      : Image.asset(
                          AppImages.closeDoor_3,
                          width: 700.w,
                          height: 700.h,
                        ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        // color: Colors.white,
                        width: 800.w,
                        height: 800.h,
                        child: ListView.separated(
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 20.h),
                          itemCount: widget.question.options.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GameButtonLight(
                              text: widget.question.options[index],
                              onPressed: () => _checkAnswer(index),
                              fromWidth: 335,
                              fromHeight: 250,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          /// الشخصية + الاحجار
          Positioned(
            bottom: 10,
            left: 20.w,
            child: BlocBuilder<PlayerCubit, PlayerModel?>(
              builder: (context, player) {
                if (player == null) return const SizedBox();

                return Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    /// الشخصية
                    Image.asset(
                      'assets/images/${player.avatar}.png',
                      height: 435.h,
                      width: 300.w,
                    ),
                    if (showStones)
                      AnimatedBuilder(
                        animation: stonesController,
                        builder: (context, child) {
                          final screenHeight = MediaQuery.of(
                            context,
                          ).size.height;

                          return Stack(
                            alignment: Alignment.topCenter,
                            children: List.generate(3, (index) {
                              double delay = index * 0.15;
                              double value = (stonesController.value - delay)
                                  .clamp(0.0, 1.0);

                              double position =
                                  (screenHeight * stonesDrop.value) * value;

                              return Transform.translate(
                                offset: Offset(
                                  (index - 1) * 60.w, // يمين وشمال بسيط
                                  position,
                                ),
                                child: Image.asset(
                                  AppImages.stones,
                                  width: 200.w,
                                ),
                              );
                            }),
                          );
                        },
                      ),
                  ],
                );
              },
            ),
          ),

          CharacterAndClueContainer(hint: widget.question.hint),
          QustionContainer(color: widget.question.color),
          TryAndTimeContainer(),
        ],
      ),
    );
  }

  void _checkAnswer(int index) async {
    if (widget.question.correctAnswer == widget.question.options[index]) {
      setState(() {
        answered = true;
      });
      SoundManager.instance.openDoor3();
      Future.delayed(const Duration(seconds: 1), () {
        onCorrect(context);
      });
      // onCorrect(context);
    } else {
      // ❌ إجابة خاطئة
      SoundManager.instance.stones();

      setState(() {
        showStones = true;
      });

      await stonesController.forward(from: 0);

      setState(() {
        showStones = false;
      });

      _resetQuestion();

      onWrong(context);
    }
  }

  void _resetQuestion() {
    setState(() {
      answered = false;
      userOrder.clear();
    });

    restartAllAnimations();
  }
}
