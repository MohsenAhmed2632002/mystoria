import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myhabits/Core/Images&colors.dart';
import 'package:myhabits/Core/animation_restart_mixin.dart';
import 'package:myhabits/Core/constants.dart';
import 'package:myhabits/Core/soundManger.dart';
import 'package:myhabits/Models/QuestionModel.dart';

class LevelTwoPuzzeleFour extends StatefulWidget {
  const LevelTwoPuzzeleFour({super.key, required this.question});
  final QuestionModel question;

  @override
  State<LevelTwoPuzzeleFour> createState() => _LevelTwoPuzzeleFourState();
}

class _LevelTwoPuzzeleFourState extends State<LevelTwoPuzzeleFour>
    with SingleTickerProviderStateMixin, RestartableAnimations {
  late AnimationController controller;
  late Animation<double> animation;
  bool freezGame = false;
  int wrongCount = 0;
  String userOrder = "";

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    );
    registerController(controller);

    animation = Tween<double>(
      begin: -1, // خارج الشاشة من الشمال
      end: 1.2, // خارج الشاشة من اليمين
    ).animate(CurvedAnimation(parent: controller, curve: Curves.linear));

    // _startAnimation();
  }

  Future<void> _startAnimation() async {
    await controller.animateTo(0.5, duration: const Duration(seconds: 2));

    // توقف في المنتصف
    await Future.delayed(const Duration(seconds: 1));

    // يكمل الحركة
    await controller.animateTo(1, duration: const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return GameScreen(
      hint: widget.question.hint,
      color: widget.question.color,
      background: widget.question.background,
      mediaQueryRight: 0,
      mediaQueryTop: 0,
      child: Container(
        // color: Colors.red,
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildChoicesContainer(widget.question.options[0]),
                _buildChoicesContainer(widget.question.options[1]),
                _buildChoicesContainer(widget.question.options[2]),
                _buildChoicesContainer(widget.question.options[3]),
              ],
            ),

            // DragTarget<String>(
            //   onAccept: (data) {
            //     setState(() {
            //       userOrder = data;
            //     });
            //     _checkResult();
            //   },
            //   builder: (context, candidateData, rejectedData) {
            //     return Container(
            //       width: 300.w,
            //       height: 250.h,
            //       child: Image.asset(
            //         AppImages.breakInMirror,
            //         fit: BoxFit.fill,
            //       ),
            //     );
            //   },
            // ),

            // Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [],
            // ),
          ],
        ),
      ),
    );
  }

  // 🚪 الباب
  Widget _buildChoicesContainer(String image) {
    return GestureDetector(
      onTap: () => _checkResult(image),

      child: Image.asset(image, width: 400.w, height: 650.h),
    );
  }

  // ✅ التحقق من الحل
  void _checkResult(String selectedImage) async {
    if (selectedImage == widget.question.correctAnswer) {
      onCorrect(context);
    } else {
      setState(() {
        wrongCount++;
      });

      /// الإجابة الخاطئة

      if (wrongCount == 1) {
        SoundManager.instance.wind();

        await _startAnimation();
      } else {
        restartAllAnimations();

        onWrong(context);
      }
    }
  }
}
