import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myhabits/Core/Font.dart';
import 'package:myhabits/Core/Images&colors.dart';
import 'package:myhabits/Core/constants.dart';
import 'package:myhabits/Models/QuestionModel.dart';

class FindMistakeWidget extends StatefulWidget {
  final QuestionModel question;

  const FindMistakeWidget({super.key, required this.question});

  @override
  State<FindMistakeWidget> createState() => _FindMistakeWidgetState();
}

class _FindMistakeWidgetState extends State<FindMistakeWidget> {
  bool fixed = false;
  @override
  Widget build(BuildContext context) {
    return GameScreen(


      color: widget.question.color,
      hint: widget.question.hint,

      background: widget.question.background,
      mediaQueryRight: 0,
      mediaQueryTop: MediaQuery.sizeOf(context).height * 0.2,
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,

        child: Stack(
          children: [
            //the image
            Positioned(
              // right: MediaQuery.sizeOf(context).width * 0.1,
              // top: MediaQuery.sizeOf(context).height * 0.05,
              right: 200.w,
              top: 100.h,
              // width: 1500.w,
              child: Image.asset(
                AppImages.paper,
                width: 1500.w,
                height: 650.h,
                fit: BoxFit.fill,
              ),
            ), //the text
            Positioned(
              // right: 200.w,
              // top: 100.h,
              right: MediaQuery.sizeOf(context).width * 0.3,
              top: MediaQuery.sizeOf(context).height * 0.25,
              child: Container(
                width: 750.w,
                // color: Colors.white,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: widget.question.options.map((word) {
                    final isWrongWord = word == widget.question.correctAnswer;

                    return GestureDetector(
                      onTap: () async {
                        if (fixed) return;

                        if (isWrongWord) {
                          // ✅ صح
                          setState(() => fixed = true);

                          // ⏳ استنى التأثير البصري
                          await Future.delayed(
                            const Duration(milliseconds: 1000),
                          );

                          // 🔊 صوت صح
                          // context.read<GameCubit>().correctAnswer(context);
                          onCorrect(context);
                          // ⏭️ الانتقال للسؤال التالي بيتم تلقائي من GameCubit
                        } else {
                          // ❌ غلط
                          onWrong(context);
                          // context.read<GameCubit>().wrongAnswer(context);
                        }
                      },
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 600),
                        transitionBuilder: (child, animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: ScaleTransition(
                              scale: Tween<double>(
                                begin: 0.8,
                                end: 1.0,
                              ).animate(animation),
                              child: child,
                            ),
                          );
                        },
                        child: fixed && isWrongWord
                            ? Text(
                                'فينيقيا',
                                key: const ValueKey('fixed'),
                                style: getRegulerTextStyle(
                                  context: context,
                                  color: Colors.green,
                                ),
                              )
                            : Text(
                                word,
                                key: ValueKey(word),
                                style: getRegulerTextStyle(
                                  context: context,
                                  color: const Color.fromRGBO(132, 25, 25, 1),
                                ),
                              ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
      // ),
      // ),
    );
  }
}
