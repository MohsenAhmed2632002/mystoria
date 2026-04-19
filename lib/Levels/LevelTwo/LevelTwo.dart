import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mystoria/Levels/LevelTwo/LevelTwoLastPuzzele.dart';
import 'package:mystoria/Levels/LevelTwo/LevelTwoLibraryPuzzle.dart';
import 'package:mystoria/Levels/LevelTwo/LevelTwoPuzzelTwo.dart';
import 'package:mystoria/Levels/LevelTwo/LevelTwoPuzzeleEighth.dart';
import 'package:mystoria/Levels/LevelTwo/LevelTwoPuzzeleFive.dart';
import 'package:mystoria/Levels/LevelTwo/LevelTwoPuzzeleFour.dart';
import 'package:mystoria/Levels/LevelTwo/LevelTwoPuzzeleOne.dart';
import 'package:mystoria/Levels/LevelTwo/LevelTwoPuzzeleSeven.dart';
import 'package:mystoria/Levels/LevelTwo/LevelTwoPuzzeleSix.dart';
import 'package:mystoria/Levels/LevelTwo/LevelTwoPuzzeleThree.dart';
import 'package:mystoria/Models/QuestionModel.dart';
import 'package:mystoria/cubit/Gamecubit/game_cubit.dart';
import 'package:mystoria/cubit/Gamecubit/game_state.dart';

class LevelTwo extends StatelessWidget {
  const LevelTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GameCubit, GameState>(
        builder: (context, state) {
          final question = context.read<GameCubit>().currentQuestion;

          return QuestionRenderer(question: question);
        },
      ),
    );
  }
}

class QuestionRenderer extends StatelessWidget {
  final QuestionModel question;

  const QuestionRenderer({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    //هنا المفروض لسته من الاسئله مش سؤال واحد بعد ما بيجاوب صح
    switch (question.type) {
      case QuestionType.order:
        return LevelTwoPuzzeleOne(question: question);

      case QuestionType.mcq:
        return LevelTwoPuzzeleTwo(question: question);

      case QuestionType.choose:
        return LevelTwoPuzzeleThree(question: question);

      case QuestionType.order2:
        return LevelTwoPuzzeleFour(question: question);

      case QuestionType.libra:
        return LevelTwoPuzzeleFive(question: question);

      case QuestionType.order3:
        return LevelTwoPuzzeleSix(question: question);

      case QuestionType.choose2:
        return LevelTwoPuzzeleBoat(question: question);

      case QuestionType.order4:
        return LevelTwoPuzzeleEleven(question: question);

      case QuestionType.libraryPuzzle:
        return LevelTwoLibraryPuzzle(question: question);
      case QuestionType.theDoor:
        return LevelTwoBordersPuzzle(question: question);

      default:
        return const Center(
          child: Text(
            'نوع سؤال غير مدعوم',
            style: TextStyle(color: Colors.red, fontSize: 20),
          ),
        );
    }
  }
}
