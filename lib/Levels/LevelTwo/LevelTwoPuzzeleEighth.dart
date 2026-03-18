import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myhabits/Core/Images&colors.dart';
import 'package:myhabits/Core/animation_restart_mixin.dart';
import 'package:myhabits/Core/constants.dart';
import 'package:myhabits/Models/QuestionModel.dart';

class LevelTwoPuzzeleEleven extends StatefulWidget {
  final QuestionModel question;

  const LevelTwoPuzzeleEleven({super.key, required this.question});

  @override
  State<LevelTwoPuzzeleEleven> createState() => _LevelTwoPuzzeleElevenState();
}

class _LevelTwoPuzzeleElevenState extends State<LevelTwoPuzzeleEleven>
    with SingleTickerProviderStateMixin, RestartableAnimations {
  late AnimationController arrowController;
  late Animation<double> arrowAnimation;
  double arrowStartX = 0;
  double arrowEndX = 0;

  bool showArrows = false;
  bool locked = false;

  @override
  void initState() {
    super.initState();
    arrowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
        registerController(arrowController);

    arrowAnimation = Tween<double>(
      begin: 0,
      end: 200,
    ).animate(CurvedAnimation(parent: arrowController, curve: Curves.easeOut));
  }


  String userChoice = "";

  @override
  Widget build(BuildContext context) {
    return GameScreen(
      hint: widget.question.hint,
      color: widget.question.color,
      background: widget.question.background,
      mediaQueryRight: 0,
      mediaQueryTop: MediaQuery.sizeOf(context).height * 0.2,
      child: Stack(
        children: [
          /// خيارات الجمل
          Container(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: widget.question.options.map((option) {
                    return GestureDetector(
                      onTap: () => _select(option),
                      child: Image.asset(
                        option,
                        width: MediaQuery.sizeOf(context).width / 2,
                        height: 1080.h,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          AnimatedBuilder(
            animation: arrowController,
            builder: (context, child) {
              final screenWidth = MediaQuery.of(context).size.width;

              double startX = screenWidth + 200; // يبدأ خارج الشاشة يمين
              double endX = 20; // عند الشخصية شمال

              return Container(
                // color: Colors.red,
                width: MediaQuery.sizeOf(context).width,
                height: 1000.h,
                child: Stack(
                  children: List.generate(6, (index) {
                    double delay = index * 0.1;

                    // نخلي كل سهم يتأخر شوية
                    double value = (arrowController.value - delay).clamp(
                      0.0,
                      1.0,
                    );

                    // نحسب مكان السهم
                    double position = startX - (startX - endX) * value;

                    // يقل شفافيته تدريجيًا
                    double opacity = (1 - value).clamp(0.0, 1.0);

                    return Positioned(
                      bottom: 220.h,
                      left: position,
                      child: Opacity(
                        opacity: opacity,
                        child: Transform.scale(
                          scale: 1 - (value * 0.3), // يصغر سنة وهو بيختفي
                          child: Image.asset(
                            AppImages.oneArow,
                            width: 250.w,
                            height: 150.h,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _select(String option) async {
    if (locked) return;

    if (option == widget.question.correctAnswer) {
      // locked = true;
      onCorrect(context);
    } else {
      arrowController.reset();
      setState(() => showArrows = true);

      await arrowController.forward(from: 0);

      setState(() => showArrows = false);
      locked = true;

      final screenWidth = MediaQuery.of(context).size.width;

      // بداية السهم من ناحية الاختيارات
      arrowStartX = screenWidth * 0.6;

      // نهاية السهم عند الأفاتار
      arrowEndX = 20;
      for (int i = 0; i < 5; i++) {
        arrowAnimation = Tween<double>(begin: arrowStartX, end: arrowEndX)
            .animate(
              CurvedAnimation(parent: arrowController, curve: Curves.easeOut),
            );

        setState(() => showArrows = true);

        await arrowController.forward(from: 0);

        arrowController.reset();
      }

      restartAllAnimations();

      onWrong(context);
      setState(() {
        showArrows = false;
        locked = false;
      });
    }
  }
}
