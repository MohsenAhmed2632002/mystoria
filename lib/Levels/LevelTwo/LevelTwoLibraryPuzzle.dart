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

class LevelTwoLibraryPuzzle extends StatefulWidget {
  final QuestionModel question;

  const LevelTwoLibraryPuzzle({super.key, required this.question});

  @override
  State<LevelTwoLibraryPuzzle> createState() => _LevelTwoLibraryPuzzleState();
}

class _LevelTwoLibraryPuzzleState extends State<LevelTwoLibraryPuzzle>
    with TickerProviderStateMixin, RestartableAnimations {
  late AnimationController sandController;
  late Animation<double> sandAnimation;

  // bool gameEnded = false;

  @override
  void initState() {
    super.initState();

    sandController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 45),
    );
    registerController(sandController);

    sandAnimation = CurvedAnimation(
      parent: sandController,
      curve: Curves.linear,
    );

    sandController.forward(from: 0);

    sandController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _timeUp();
      }
    });
  }

  // @override
  // void dispose() {
  //   sandController.dispose();
  //   super.dispose();
  // }

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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(AppImages.sandglass, width: 400.w, height: 1080.h),
                _buildDoor(widget.question.options[0]),
                _buildDoor(widget.question.options[1]),
                _buildDoor(widget.question.options[2]),
              ],
            ),
          ),

          /// الشخصية + الرمل
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
                    AnimatedBuilder(
                      animation: sandAnimation,
                      builder: (context, child) {
                        return Align(
                          alignment: Alignment.bottomCenter,
                          child: Image.asset(
                            AppImages.sand,
                            fit: BoxFit.fill,
                            width: 300.w,
                            height: 435.h * sandAnimation.value,
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
      // gameEnded = true;

      sandController.stop();
      SoundManager.instance.sandFlow();

      await Future.delayed(const Duration(milliseconds: 500));

      if (mounted) {
        onCorrect(context);
      }
    } else {
      // gameEnded = true;

      SoundManager.instance.wind();

      if (mounted) {
        restartAllAnimations();

        onWrong(context);
      }
    }
  }

  void _timeUp() {
    // gameEnded = true;

    SoundManager.instance.wind();

    if (mounted) {
      restartAllAnimations();

      onWrong(context);
    }
  }
}
