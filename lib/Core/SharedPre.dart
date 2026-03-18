import 'package:myhabits/Models/PlayerModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayerStorage {
  static late SharedPreferences prefs;
  static const _nameKey = 'player_name';
  static const _avatarKey = 'player_avatar';
  // static const _stageKey = 'current_stage';

  static Future<void> initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<void> setPlayer(PlayerModel player) async {
    await prefs.setString(_nameKey, player.name);
    await prefs.setString(_avatarKey, player.avatar);
  }

  static Future<PlayerModel?> getPlayer() async {
    final name = prefs.getString(_nameKey);
    final avatar = prefs.getString(_avatarKey);

    if (name == null || avatar == null) return null;
    return PlayerModel(name: name, avatar: avatar);
  }

  // static Future<void> saveStage(int stage) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setInt(_stageKey, stage);
  // }
  //  static Future<int> loadStage() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getInt(_stageKey) ?? 1;
  // }
}
