import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myhabits/Core/Font.dart';
import 'package:myhabits/Core/Images&colors.dart';
import 'package:myhabits/Core/constants.dart';
import 'package:myhabits/Core/soundManger.dart';
import 'package:myhabits/Models/QuestionModel.dart';
import 'package:myhabits/cubit/Gamecubit/game_cubit.dart';

class LevelTwoPuzzeleTwo extends StatefulWidget {
  final QuestionModel question;

  LevelTwoPuzzeleTwo({super.key, required this.question});

  @override
  State<LevelTwoPuzzeleTwo> createState() => _LevelTwoPuzzeleTwoState();
}
class _LevelTwoPuzzeleTwoState extends State<LevelTwoPuzzeleTwo> {
  bool freezGame = false;
  int wrongCount = 0;

  @override
  Widget build(BuildContext context) {
    return GameScreen(
      hint: widget.question.hint,
      color: widget.question.color,
      background: widget.question.background,
      mediaQueryRight: 0,
      mediaQueryTop: MediaQuery.sizeOf(context).height * 0.2,
      child: Center(
        child: SizedBox(
          width: 2000.w,
          height: 1000.h,
          child: GridView.builder(
            itemCount: widget.question.options.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 40,
              crossAxisSpacing: 40,
              childAspectRatio: 3,
            ),
            itemBuilder: (context, index) {
              final option = widget.question.options[index];
          
              return GameButtonThree(
                text: option,
                onPressed: () async {
                  if (freezGame) return;
          
                  /// الإجابة الصحيحة
                  if (option == widget.question.correctAnswer) {
                    SoundManager.instance.correct();
                    onCorrect(context);
                    return;
                  }
          
                  /// الإجابة الخاطئة
                  wrongCount++;
          
                  if (wrongCount == 1) {
                    SoundManager.instance.lamp();
                    await _firstWrong(context);
                  } else {
                    SoundManager.instance.wrong();
                    
                    onWrong(context);
                  }
                },
                fromWidth: 0,
                fromHeight: 0,
                fontSize: 50,
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _firstWrong(BuildContext context) async {
    freezGame = true;
    setState(() {});

    SoundManager.instance.lamp();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(30.w),
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(AppImages.dialog)),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              "حاول مرة اخرى",
              style: getArabLightTextStyle(
                context: context,
                fontSize: 80.sp,
                color: AppColors.accentColor,
              ),
            ),
          ),
        ),
      ),
    );

    await Future.delayed(const Duration(seconds: 5));

    if (mounted) Navigator.pop(context);

    freezGame = false;
    setState(() {});
  }
}
