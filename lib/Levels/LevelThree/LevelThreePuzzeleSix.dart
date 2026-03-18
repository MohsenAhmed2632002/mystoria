import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myhabits/Core/Images&colors.dart';
import 'package:myhabits/Core/animation_restart_mixin.dart';
import 'package:myhabits/Core/constants.dart';
import 'package:myhabits/Core/soundManger.dart';
import 'package:myhabits/Models/QuestionModel.dart';
import 'package:myhabits/cubit/Gamecubit/game_cubit.dart';

class LevelThreePuzzeleSix extends StatefulWidget {
  LevelThreePuzzeleSix({super.key, required this.question});
  final QuestionModel question;

  @override
  State<LevelThreePuzzeleSix> createState() => _LevelThreePuzzeleSixViewState();
}

class _LevelThreePuzzeleSixViewState extends State<LevelThreePuzzeleSix>
    with TickerProviderStateMixin, RestartableAnimations {
  final List<String> userOrder = [];
  final List<String> emptines = [
    AppImages.emptiness3,
    AppImages.emptiness2,
    AppImages.emptiness1,
  ];

  late AnimationController _rockController;
  late Animation<Offset> _rockAnimation;

  late AnimationController _textController;
  late Animation<double> _textFadeAnimation;

  @override
  void initState() {
    super.initState();

    // أنيميشن الصخور: تبدأ من Offset(0, -5) لتكون بعيدة جداً عن الشاشة في البداية
    _rockController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _rockAnimation =
        Tween<Offset>(
          begin: const Offset(0, -3),
          end: const Offset(0, 1  ),
        ).animate(
          CurvedAnimation(parent: _rockController, curve: Curves.bounceOut),
        );

    // أنيميشن النص
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _textFadeAnimation = CurvedAnimation(
      parent: _textController,
      curve: Curves.easeIn,
    );

    registerController(_rockController);
    registerController(_textController);

    SoundManager.instance.stopBgm().then((_) {
      BlocProvider.of<GameCubit>(context).initState(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GameScreen(
      color: widget.question.color,
      hint: widget.question.hint,
      background: widget.question.background,
      mediaQueryRight: 0,
      mediaQueryTop: 0,
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        // color: Colors.white,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            // المحتوى الأساسي في المنتصف
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // نص رمسيس الثاني
                FadeTransition(
                  opacity: _textFadeAnimation,
                  child: Text(
                    "رمسيس الثاني",
                    style: TextStyle(
                      fontSize: 45.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber,
                      shadows: [
                        const Shadow(blurRadius: 15, color: Colors.black),
                      ],
                    ),
                  ),
                ),
                // SizedBox(height: 30.h),

                // منطقة الهدف (Drag Target)
                DragTarget<String>(
                  onAccept: (data) {
                    if (userOrder.length < 3) {
                      setState(() => userOrder.add(data));
                      if (userOrder.length == 3) _checkResult();
                    }
                  },
                  builder: (context, candidateData, rejectedData) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(3, (index) {
                        return Container(
                          width: 300.w,
                          height: 300.h,

                          margin: EdgeInsets.symmetric(horizontal: 5.w),
                          decoration: BoxDecoration(
                            // color: Colors.black,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.amber.withOpacity(0.5),
                              width: 2,
                            ),
                          ),
                          child: userOrder.length > index
                              ? Image.asset(
                                  userOrder[index],
                                  width: 300.w,
                                  height: 300.h,
                                )
                              : Image.asset(
                                  emptines[index],
                                  width: 300.w,
                                  height: 300.h,
                                  // fit: BoxFit.contain,
                                ),
                        );
                      }),
                    );
                  },
                ),

                // SizedBox(height: 50.h),

                // البرديات المتاحة
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Wrap(
                    spacing: 15.w,
                    runSpacing: 15.h,
                    alignment: WrapAlignment.center,
                    children: widget.question.options.map((option) {
                      bool isSelected = userOrder.contains(option);
                      return AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: isSelected ? 0.0 : 1.0,
                        child: isSelected
                            ? SizedBox(width: 80.w, height: 110.h)
                            : _buildDraggableItem(option),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),

            // صخور الحائط التي تسقط عند الخطأ
            SlideTransition(
              position: _rockAnimation,
              child: Image.asset(
                AppImages.stones2, // تأكد أن هذا المسار صحيح في الـ Assets
                // width: 1000.w, // ملء عرض الشاشة
                height: 500.h, // ملء ارتفاع الشاشة
                // fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDraggableItem(String image) {
    return Draggable<String>(
      data: image,
      feedback: Image.asset(image, width: 300.w, height: 300.h),
      childWhenDragging: Opacity(
        opacity: 0.3,
        child: Image.asset(image, width: 300.w, height: 300.h),
      ),
      child: Image.asset(image, width: 300.w, height: 300.h),
    );
  }

  void _checkResult() async {
    List<String> correct = widget.question.correctAnswer;
    bool isCorrect = true;

    for (int i = 0; i < 3; i++) {
      if (userOrder[i] != correct[i]) {
        isCorrect = false;
        break;
      }
    }

    if (isCorrect) {
      _textController.forward();
      onCorrect(context);
    } else {
      _rockController.reverse();
      setState(() => userOrder.clear());
      // تشغيل أنيميشن السقوط
      await _rockController.forward();
      // انتظر قليلاً والصخور مغطية الشاشة
      await Future.delayed(const Duration(milliseconds: 600));

      onWrong(context);
      // أعد الصخور للأعلى وامسح الإجابات
    }
  }
}
