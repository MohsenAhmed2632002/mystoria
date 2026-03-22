import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myhabits/Levels/LevelOne/LastPuzzele.dart';
import 'package:myhabits/Levels/LevelOne/LibraryPuzzle.dart'; 
import 'package:myhabits/Levels/LevelOne/PuzzelTwo.dart';
import 'package:myhabits/Levels/LevelOne/PuzzeleEighth.dart';
import 'package:myhabits/Levels/LevelOne/PuzzeleFive.dart';
import 'package:myhabits/Levels/LevelOne/PuzzeleSeven.dart';
import 'package:myhabits/Levels/LevelOne/PuzzeleSix.dart';
import 'package:myhabits/Levels/LevelOne/PuzzeleThree.dart';
import 'package:myhabits/Models/QuestionModel.dart';
import 'package:myhabits/Levels/LevelOne/PuzzeleOne.dart';
import 'package:myhabits/cubit/Gamecubit/game_cubit.dart';
import 'package:myhabits/cubit/Gamecubit/game_state.dart';

class LevelOne extends StatelessWidget {
  const LevelOne({super.key});

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
        return PuzzleOrder(question: question);

      case QuestionType.mcq:
        return McqWidget(question: question);

      case QuestionType.choose:
        return ChooseWidget(question: question);

      case QuestionType.order2:
        return PuzzleCrown(question: question);

      case QuestionType.findMistake:
        return FindMistakeWidget(question: question);

      case QuestionType.order3:
        return NetworkQ();

      case QuestionType.choose2:
        return ChooseHWidget(question: question);
      case QuestionType.order4:
        return PuzzeleCemeteries(question: question);

      case QuestionType.libraryPuzzle:
        return LibraryPuzzle(question: question);
      case QuestionType.theDoor:
        return TheDoorQuestion(question: question);

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
