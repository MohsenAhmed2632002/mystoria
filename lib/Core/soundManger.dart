import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

class SoundManager {
  SoundManager._internal() {
    bgmVolume.addListener(_applyVolume);
    sfxVolume.addListener(_applyVolume);
  }

  static final SoundManager instance = SoundManager._internal();

  final AudioPlayer _bgmPlayer = AudioPlayer();
  final ValueNotifier<double> bgmVolume = ValueNotifier(1.0);

  // final AudioPlayer _sfxPlayer = AudioPlayer();

  /// 🎚️ تحكم الصوت
  final ValueNotifier<double> sfxVolume = ValueNotifier(1.0);

  bool _bgmPlaying = false;

  void _applyVolume() {
    _bgmPlayer.setVolume(bgmVolume.value);
    // _sfxPlayer.setVolume(sfxVolume.value);
  }

  /// 🎵 موسيقى الخلفية
  Future<void> playBgm(String path) async {
    if (_bgmPlaying) return;

    await _bgmPlayer.setReleaseMode(ReleaseMode.loop);
    await _bgmPlayer.play(AssetSource(path));
    _applyVolume();
    _bgmPlaying = true;
  }

  Future<void> stopBgm() async {
    await _bgmPlayer.stop();
    _bgmPlaying = false;
  }
  // stopEarthCracked

  /// 🔊 مؤثرات صوتية
  Future<void> playSfx(String path) async {
    final player = AudioPlayer();
    await player.setReleaseMode(ReleaseMode.stop);
    await player.setVolume(sfxVolume.value);
    await player.play(AssetSource(path));
  }

  Future<void> stopSfx() async => await _bgmPlayer.stop();

  // 🎯 اختصارات جاهزة
  void correct() => playSfx('sound/true.aac');
  void wrong() => playSfx('sound/false.mp3');
  void lamp() => playSfx('sound/lamp.mp3');
  void wind() => playSfx('sound/wind.mp3');
  void iron() => playSfx('sound/iron.mp3');
  void ironFall() => playSfx('sound/iron_fall.mp3');
  void closeTheBox() => playSfx('sound/iron_fall.mp3');
  void sandFlow() => playSfx('sound/sand_flow.mp3');
  void waterAndBird() => playSfx('sound/water_and_bird.mp3');
  void closeBox() => playSfx('sound/close_box.mp3');
  void openDoor3() => playSfx('sound/Open_door3.mp3');
  void stones() => playSfx('sound/stones.mp3');
  void openDoor() => playSfx('sound/Open_door.mp3');
  void effectOpenDoor() => playSfx('sound/effect_open_door.mp3');
  void doorMakbara() => playSfx('sound/Door_makbara.mp3');
  void openLamp() => playSfx('sound/Open_lamp.mp3');
  void openCoffin() => playSfx('sound/Open_coffin.mp3');
  void earthCracked() => playSfx('sound/Earth_cracked.mp3');
  void falling() => playSfx('sound/Falling.mp3');
}
