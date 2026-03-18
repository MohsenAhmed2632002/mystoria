import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myhabits/Levels/LevelThree/LevelThreeLastPuzzele.dart';
import 'package:myhabits/Levels/LevelThree/LevelThreeLibraryPuzzle.dart';
import 'package:myhabits/Levels/LevelThree/LevelThreePuzzelTwo.dart';
import 'package:myhabits/Levels/LevelThree/LevelThreePuzzeleEighth.dart';
import 'package:myhabits/Levels/LevelThree/LevelThreePuzzeleFive.dart';
import 'package:myhabits/Levels/LevelThree/LevelThreePuzzeleFour.dart';
import 'package:myhabits/Levels/LevelThree/LevelThreePuzzeleOne.dart';
import 'package:myhabits/Levels/LevelThree/LevelThreePuzzeleSeven.dart';
import 'package:myhabits/Levels/LevelThree/LevelThreePuzzeleSix.dart';
import 'package:myhabits/Levels/LevelThree/LevelThreePuzzeleThree.dart';
import 'package:myhabits/Models/QuestionModel.dart';
import 'package:myhabits/cubit/Gamecubit/game_cubit.dart';
import 'package:myhabits/cubit/Gamecubit/game_state.dart';

class LevelThree extends StatelessWidget {
  const LevelThree({super.key});

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
        return LevelThreePuzzeleOne(question: question);

      case QuestionType.mcq:
        return LevelThreePuzzeleTwo(question: question);

      case QuestionType.choose:
        return LevelThreePuzzeleThree(question: question);

      case QuestionType.order2:
        return LevelThreePuzzeleFour(question: question);

      case QuestionType.libra:
        return LevelThreePuzzeleFive(question: question);

      case QuestionType.order3:
        return LevelThreePuzzeleSix(question: question);

      case QuestionType.choose2:
        return LevelThreePuzzeleBoat(question: question);

            case QuestionType.order4:
              return LevelThreePuzzeleEleven(question: question);

      case QuestionType.libraryPuzzle:
        return LevelThreeLibraryPuzzle(question: question);
      case QuestionType.theDoor:
        return LevelThreeBordersPuzzle(question: question);

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
