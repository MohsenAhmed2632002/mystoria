import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myhabits/Core/Images&colors.dart';
import 'package:myhabits/Core/animation_restart_mixin.dart';
import 'package:myhabits/Core/constants.dart';
import 'package:myhabits/Core/soundManger.dart';
import 'package:myhabits/Models/PlayerModel.dart';
import 'package:myhabits/Models/QuestionModel.dart';
import 'package:myhabits/cubit/Playercubit/Playercubit.dart';

class LevelThreeLibraryPuzzle extends StatefulWidget {
  final QuestionModel question;

  const LevelThreeLibraryPuzzle({super.key, required this.question});

  @override
  State<LevelThreeLibraryPuzzle> createState() =>
      _LevelThreeLibraryPuzzleState();
}

class _LevelThreeLibraryPuzzleState extends State<LevelThreeLibraryPuzzle> {
  bool answered = false;
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

          /// الأبواب + ساعة الرمل
          Positioned(
            top: MediaQuery.sizeOf(context).height * 0.1,
            left: 0,
            right: 0,
            child: Container(
              // color: Colors.cyan,
              height: MediaQuery.sizeOf(context).height * 0.9,
              width: MediaQuery.sizeOf(context).width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  answered
                      ? Image.asset(
                          AppImages.door_quiz9,
                          width: 700.w,
                          height: 700.h,
                        )
                      : Image.asset(
                          AppImages.open_door_quiz9,
                          width: 700.w,
                          height: 700.h,
                        ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.end,
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
                              onPressed: () =>
                                  _select(widget.question.options[index]),
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

          /// الشخصية + الرمل
          Positioned(
            bottom: 10,
            left: 20.w,
            child: BlocBuilder<PlayerCubit, PlayerModel?>(
              builder: (context, player) {
                if (player == null) return const SizedBox();

                return
                /// الشخصية
                Image.asset(
                  'assets/images/${player.avatar}.png',
                  height: 435.h,
                  width: 300.w,
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

  Widget _buildDoor(String imagePath) {
    return GestureDetector(
      onTap: () => _select(imagePath),
      child: Image.asset(imagePath, width: 350.w, height: 600.h),
    );
  }

  void _select(String choice) async {
    // if (gameEnded) return;

    if (choice == widget.question.correctAnswer) {
      answered = true;

      // sandController.stop();
      // SoundManager.instance.sandFlow();

      await Future.delayed(const Duration(milliseconds: 500));

      // if (mounted) {
      onCorrect(context);
      // }
    } else {
      // gameEnded = true;

      // SoundManager.instance.wind();

      // if (mounted) {
      // restartAllAnimations();

      onWrong(context);
      // }
    }
  }
}
