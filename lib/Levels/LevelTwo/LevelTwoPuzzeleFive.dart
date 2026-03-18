import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myhabits/Core/Images&colors.dart';
import 'package:myhabits/Core/animation_restart_mixin.dart';
import 'package:myhabits/Core/constants.dart';
import 'package:myhabits/Core/soundManger.dart';
import 'package:myhabits/Models/QuestionModel.dart';

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

      background: AppImages.quiz4,
      mediaQueryRight: 0,
      mediaQueryTop: MediaQuery.sizeOf(context).height * 0.05,
      child: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Center(
          child: Container(
            // color: Colors.red,
            width: 1080.w,
            height: 900.h,
            child: Stack(
              children: [
                Image.asset(
                  balanceImage,
                  width: 1080.w,
                  height: 1000.h,
                  fit: BoxFit.fill,
                ),
                Container(
                  width: 1080.w,
                  height: 900.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            userOrder = widget.question.options[1];
                            _checkResult();
                          });
                        },
                        child: AnimatedBuilder(
                          animation: controller,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(0, moveAnimationLeft.value),
                              child: child,
                            );
                          },
                          child: Container(
                            width: 350.w,
                            height: 350.h,

                            child: Image.asset(widget.question.options[1]),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            userOrder = widget.question.options[0];
                            _checkResult();
                          });
                        },
                        child: AnimatedBuilder(
                          animation: controller,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(0, moveAnimationRight.value),
                              child: child,
                            );
                          },
                          child: Container(
                            width: 350.w,
                            height: 350.h,

                            child: Image.asset(
                              widget.question.options[0],
                              // textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
