import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:myhabits/Core/Routes.dart';
import 'package:myhabits/Core/soundManger.dart';
import 'package:myhabits/Models/LevelsModel.dart';
import 'package:myhabits/Models/gameModel.dart';
import 'package:myhabits/cubit/Gamecubit/game_state.dart';

class GameCubit extends Cubit<GamePlaying> {
  GameCubit({required this.levels}) : super(GamePlaying(GameModel.initial()));

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
    emit(GamePlaying(GameModel.initial().copyWith(currentLevel: levelIndex)));

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

  // int calculateStarsPreview() {
  //   if (game.timeLeft >= 30) return 3;
  //   if (game.timeLeft >= 15) return 2;
  //   return 1;
  // }

  /// -----------------------------
  /// CORRECT ANSWER
  /// -----------------------------
  void correctAnswer(BuildContext context) {
    // SoundManager.instance.correct();
    _timer?.cancel();

    final isLastQuestion = game.currentPuzzle >= questions.length - 1;

    int newCounter = game.correctAnswerCounter + 1;
    int newAttempts = game.attempts;
    int newHelps = game.helps;
    if (newCounter == 4) {
      newAttempts += 1;
      newHelps += 1;
      newCounter = 0;
    }

    emit(
      GamePlaying(
        game.copyWith(
          stars: game.stars + calculateStars(),
          correctAnswerCounter: newCounter,
          attempts: newAttempts,
          currentPuzzle: isLastQuestion
              ? game.currentPuzzle
              : game.currentPuzzle + 1,
          timeLeft: 30,
          helps: newHelps,
          
        ),
      ),
    );

    if (isLastQuestion) {
      // SoundManager.instance.stopBgm();

      Navigator.pushReplacementNamed(context, Routes.levelMapScreen);
      stopTimer();
      // return;
    }

    startTimer(context);
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

      startTimer(context);
    } else {
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

  void exitGame() {
    _timer?.cancel();
    SoundManager.instance.stopBgm();
  }
}

  // void initState(context) async {
  //   startTimer(context);

  //   await SoundManager.instance.playBgm('sound/music_game.mp3');
  // }
  // void exitGame() {
  //   _timer?.cancel();
  //   SoundManager.instance.stopBgm();
  // }
