import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myhabits/Core/SharedPre.dart';
import 'package:myhabits/Models/PlayerModel.dart';

class PlayerCubit extends Cubit<PlayerModel?> {
  PlayerCubit() : super(null);

  Future<void> loadPlayer() async {
    final player = await PlayerStorage.getPlayer();
    emit(player);
  }

  Future<void> setPlayer(PlayerModel player) async {
    await PlayerStorage.setPlayer(player);
    emit(player);
  }
}
