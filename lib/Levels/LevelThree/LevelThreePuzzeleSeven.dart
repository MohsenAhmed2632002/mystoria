import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myhabits/Core/Images&colors.dart';
import 'package:myhabits/Core/constants.dart';
import 'package:myhabits/Core/soundManger.dart';
import 'package:myhabits/Models/QuestionModel.dart';

class LevelThreePuzzeleBoat extends StatefulWidget {
  final QuestionModel question;
  const LevelThreePuzzeleBoat({super.key, required this.question});

  @override
  State<LevelThreePuzzeleBoat> createState() => _LevelThreePuzzeleBoatState();
}

class _LevelThreePuzzeleBoatState extends State<LevelThreePuzzeleBoat> {
 String? selectedChoice;
  @override
  Widget build(BuildContext context) {
    return GameScreen(
      mediaQueryRight: 0,
      mediaQueryTop: MediaQuery.of(context).size.height * 0.1,
      hint: widget.question.hint,
      color: widget.question.color,

      background: AppImages.quiz3_7,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildDoor(widget.question.options[0]),
            _buildDoor(widget.question.options[1]),
            _buildDoor(widget.question.options[2]),
          ],
        ),
      ),
    );
  }

  Widget _buildDoor(String imagePath) {
    // التعديل هنا: التلوين يحدث فقط لو كان هذا التابوت هو المختار وهو الإجابة الصحيحة
    bool isCorrectAndSelected =
        (selectedChoice == imagePath) &&
        (imagePath == widget.question.correctAnswer);

    return GestureDetector(
      onTap: () => _select(imagePath),
      child: Image.asset(
        imagePath,
        width: 400.w,
        height: 650.h,
        // التلوين بناءً على الشرط الجديد
        color: isCorrectAndSelected ? Colors.yellowAccent : null,
      ),
    );
  }

  void _select(String choice) async {
    if (choice == widget.question.correctAnswer) {
      selectedChoice = choice;

      // sandController.stop();
      SoundManager.instance.openCoffin();

      await Future.delayed(const Duration(milliseconds: 500));

      onCorrect(context);
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
