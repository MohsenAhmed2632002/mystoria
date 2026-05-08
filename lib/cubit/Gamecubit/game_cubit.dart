import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:mystoria/Core/Routes.dart';
import 'package:mystoria/Core/SharedPre.dart';
import 'package:mystoria/Core/soundManger.dart';
import 'package:mystoria/Models/QuestionModel.dart';
import 'package:mystoria/Models/gameModel.dart';
import 'package:mystoria/cubit/Gamecubit/game_state.dart';

class GameCubit extends Cubit<GamePlaying> {
  GameCubit({required this.levels}) : super(GamePlaying(GameModel.initial())) {
    _loadInitialData();
  }
  final List<LevelModel> levels;
  Timer? _timer;

  GameModel get game => state.theGame;

  /// -----------------------------
  /// LEVEL + QUESTION ACCESS
  /// -----------------------------
  LevelModel get currentLevel => levels[game.currentLevel];

  List get questions => currentLevel.questions;

  get currentQuestion => questions[game.currentPuzzle];

  bool get isLastQuestion => game.currentPuzzle == questions.length - 1;
  bool get isLastLevel => game.currentLevel == levels.length - 1;
  bool _isPaused = false;

  /// -----------------------------
  /// START LEVEL
  /// -----------------------------

  void initState(context) async {
    // await SoundManager.instance.stopBgm();
    startTimer(context);

    await SoundManager.instance.playBgm('sound/music_game.mp3');
  }

  void startLevel(int levelIndex, BuildContext context) {
    GameModel.initial().copyWith(
      currentLevel: levelIndex,
      stars: game.stars,
      attempts: game.attempts,
      hints: game.hints,
    );

    startTimer(context);
    SoundManager.instance.playBgm('sound/music_game.mp3');
  }

  /// -----------------------------
  /// TIMER
  /// -----------------------------
  void startTimer(BuildContext context) {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isPaused) return;

      if (game.timeLeft > 0) {
        emit(GamePlaying(game.copyWith(timeLeft: game.timeLeft - 1)));
      } else {
        timer.cancel();
        wrongAnswer(context);
      }
    });
  }

  Future<void> stopTimeFiveSeconds(BuildContext context) async {
    _isPaused = true;
    await Future.delayed(const Duration(seconds: 5));
    _isPaused = false;
    startTimer(context);
  }

  void stopTimer() {
    _timer?.cancel();
  }

  /// -----------------------------
  /// STARS
  /// -----------------------------
  int calculateStars() {
    if (game.timeLeft >= 20) return 3;
    if (game.timeLeft >= 10) return 2;
    return 1;
  }

  /// -----------------------------
  /// CORRECT ANSWER
  /// -----------------------------/// -----------------------------
  /// CORRECT ANSWER (المعدل)
  /// -----------------------------
  void correctAnswer(BuildContext context) async {
    _timer?.cancel();

    final isLastQuestion = game.currentPuzzle >= questions.length - 1;

    int newCounter = game.correctAnswerCounter + 1;
    int newAttempts = game.attempts;
    int newHints = game.hints;

    if (newCounter == 4) {
      newAttempts += 1;
      newHints += 1;
      newCounter = 0;
    }

    final gainedStars = calculateStars();

    // ✅ 1. احسب الإجمالي الجديد
    int tempTotalStars = game.stars + gainedStars;

    // ✅ 2. احصل على الحد الأقصى للمستوى الحالي
    int maxStars = _getMaxStarsForLevel(game.currentLevel);

    // ✅ 3. لا تسمح بتجاوز الحد الأقصى
    int newStars = tempTotalStars > maxStars ? maxStars : tempTotalStars;

    emit(
      GamePlaying(
        game.copyWith(
          stars: newStars,
          correctAnswerCounter: newCounter,
          attempts: newAttempts,
          currentPuzzle: isLastQuestion
              ? game.currentPuzzle
              : game.currentPuzzle + 1,
          timeLeft: 30,
          hints: newHints,
        ),
      ),
    );

    /// حفظ النجوم في آخر سؤال
    if (isLastQuestion) {
      // ✅ 4. النجوم محسوبة بالفعل بشكل صحيح ولا تتجاوز الحد
      await PlayerStorage.saveStars(newStars);
      await PlayerStorage.saveAttempts(newAttempts);
      await PlayerStorage.saveHints(newHints);

      // ✅ 5. تحديث النجوم المخزنة للقادم
      emit(GamePlaying(game.copyWith(stars: newStars)));

      if (context.mounted) {
        Navigator.pushReplacementNamed(context, Routes.levelMapScreen);
      }
      stopTimer();
      return;
    }

    startTimer(context);
  }

  int _getMaxStarsForLevel(int level) {
    switch (level) {
      case 0:
        return 30;
      case 1:
        return 60;
      case 2:
        return 90;
      default:
        return 999;
    }
  }

  /// -----------------------------
  /// WRONG ANSWER
  /// -----------------------------
  void wrongAnswer(BuildContext context) {
    // SoundManager.instance.wrong();
    stopTimer();

    if (game.attempts > 1) {
      emit(
        GamePlaying(
          game.copyWith(
            attempts: game.attempts - 1,
            correctAnswerCounter: 0,
            timeLeft: 30,
          ),
        ),
      );
      // Navigator.pop(context);
      startTimer(context);
    } else {
      // Navigator.pop(context);
      resetLevel(context);
    }
  }

  /// -----------------------------
  /// FINISH LEVEL
  /// -----------------------------
  void finishLevel(BuildContext context) {
    stopTimer();

    Navigator.pushReplacementNamed(context, Routes.levelMapScreen);
  }

  /// -----------------------------
  /// RESET LEVEL
  /// -----------------------------
  void resetLevel(BuildContext context) {
    stopTimer();

    emit(
      GamePlaying(
        GameModel.initial().copyWith(currentLevel: game.currentLevel),
      ),
    );

    startTimer(context);
  }

  @override
  Future<void> close() {
    stopTimer();
    return super.close();
  }

  void exitGame(BuildContext context) {
    _timer?.cancel();
    SoundManager.instance.stopBgm();
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, Routes.homeScreen);
  }

  Future<void> _loadInitialData() async {
    final savedStars = await PlayerStorage.loadStars();
    final savedAttempts = await PlayerStorage.loadAttempts();
    final savedHints = await PlayerStorage.loadHints();

    emit(
      GamePlaying(
        state.theGame.copyWith(
          stars: savedStars,
          attempts: savedAttempts,
          hints: savedHints,
        ),
      ),
    );
  }
}
