import 'dart:ui';


enum QuestionType {
  order,
  order2,
  order3,
  order4,
  mcq,
  match,
  findMistake,
  choose,
  choose2,
  theDoor,
  libraryPuzzle,
  libra,
}

class QuestionModel {
  final QuestionType type;
  final String question;
  final List<String> options;
  final dynamic correctAnswer;
  final String background;
  final String hint;
  final Color color;

  QuestionModel({
    required this.type,
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.background,
    required this.hint,
    required this.color,
  });
}