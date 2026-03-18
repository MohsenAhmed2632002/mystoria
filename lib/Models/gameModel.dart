class GameModel {
  final int stars;
  int helps;
  final int attempts;
  final int correctAnswerCounter; // إجابات صح متتالية
  final int timeLeft;
  final int currentPuzzle;
  final int currentLevel;

  GameModel({
    required this.stars,
    required this.helps,
    required this.attempts,
    required this.correctAnswerCounter,
    required this.timeLeft,
    required this.currentPuzzle,
    required this.currentLevel,
  });

  factory GameModel.initial() {
    return GameModel(
      stars: 0,
      helps: 0,
      attempts: 0,
      correctAnswerCounter: 0,
      timeLeft: 30,
      currentPuzzle: 0,
      currentLevel: 0,
    );
  }

  GameModel copyWith({
    int? stars,
    int? helps,
    int? attempts,
    int? correctAnswerCounter,
    int? timeLeft,
    int? currentPuzzle,
    int? currentLevel,
  }) {
    return GameModel(
      stars: stars ?? this.stars,
      helps: helps ?? this.helps,
      attempts: attempts ?? this.attempts,
      correctAnswerCounter: correctAnswerCounter ?? this.correctAnswerCounter,
      timeLeft: timeLeft ?? this.timeLeft,
      currentPuzzle: currentPuzzle ?? this.currentPuzzle,
      currentLevel: currentLevel ?? this.currentLevel,
    );
  }
}
