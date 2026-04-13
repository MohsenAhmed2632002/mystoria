class GameModel {
  final int stars;
  int hints;
  final int attempts;
  final int correctAnswerCounter; // إجابات صح متتالية
  final int timeLeft;
  final int currentPuzzle;
  final int currentLevel;

  GameModel({
    required this.stars,
    required this.hints,
    required this.attempts,
    required this.correctAnswerCounter,
    required this.timeLeft,
    required this.currentPuzzle,
    required this.currentLevel,
  });

  factory GameModel.initial() {
    return GameModel(
      stars: 90,

      hints: 50,
      attempts: 30,
      correctAnswerCounter: 0,
      timeLeft: 30,
      currentPuzzle: 0,
      currentLevel: 0,
    );
  }

  GameModel copyWith({
    int? stars,
    int? hints,
    int? attempts,
    int? correctAnswerCounter,
    int? timeLeft,
    int? currentPuzzle,
    int? currentLevel,
  }) {
    return GameModel(
      stars: stars ?? this.stars,
      hints: hints ?? this.hints,
      attempts: attempts ?? this.attempts,
      correctAnswerCounter: correctAnswerCounter ?? this.correctAnswerCounter,
      timeLeft: timeLeft ?? this.timeLeft,
      currentPuzzle: currentPuzzle ?? this.currentPuzzle,
      currentLevel: currentLevel ?? this.currentLevel,
    );
  }
}
