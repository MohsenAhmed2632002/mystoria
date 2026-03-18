import 'package:flutter/material.dart';
import 'package:myhabits/Core/Images&colors.dart';
import 'package:myhabits/Core/constants.dart';
import 'package:myhabits/Models/QuestionModel.dart';

class McqWidget extends StatelessWidget {
  final QuestionModel question;

  const McqWidget({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return GameScreen(
      hint: question.hint,
      color: question.color,
      background: AppImages.quiz2,
      mediaQueryRight: 0,
      mediaQueryTop: 0,
      child: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: question.options.map((option) {
                return GameButtonTwo(
                  text: option,
                  onPressed: () {
                    // final cubit = context.read<GameCubit>();

                    if (option == question.correctAnswer) {
                      // ✅ صح
                      // SoundManager.playCorrect();
                      onCorrect(context);
                      // onWrong(  context);
                      // cubit.correctAnswer(context);
                    } else {
                      // ❌ غلط
                      // SoundManager.playWrong();
                      // cubit.wrongAnswer(context);
                      // onCorrect(context);
                      onWrong(context);
                    }
                  },
                  fromWidth: 550,
                  fromHeight: 200,
                  fontSize: 35,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
