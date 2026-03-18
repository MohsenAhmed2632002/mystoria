import 'package:equatable/equatable.dart';
import 'package:myhabits/Models/gameModel.dart';

abstract class GameState extends Equatable {
  const GameState();

  @override
  List<Object?> get props => [];
}

class GameInitial extends GameState {}


class GamePlaying extends GameInitial {
  final GameModel theGame;

  GamePlaying(this.theGame);

  @override
  List<Object?> get props => [theGame];

  operator >=(int other) {}
}

// class GameWrongAnswer extends GameInitial {
//   final GameModel theGame;

//   GameWrongAnswer(this.theGame);

//   @override
//   List<Object?> get props => [theGame];

//   operator >=(int other) {}
// }

// // 