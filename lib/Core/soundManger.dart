import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

// // class SoundManager {
// //   SoundManager._internal() {
// //     bgmVolume.addListener(_applyVolume);
// //     sfxVolume.addListener(_applyVolume);
// //   }
// //   Future<void> pauseBgm() async {
// //     await _bgmPlayer.pause();
// //   }

// //   Future<void> resumeBgm() async {
// //     await _bgmPlayer.resume();
// //   }

// //   static final SoundManager instance = SoundManager._internal();

// //   final AudioPlayer _bgmPlayer = AudioPlayer();
// //   final ValueNotifier<double> bgmVolume = ValueNotifier(1.0);

// //   final AudioPlayer _sfxPlayer = AudioPlayer();

// //   /// 🎚️ تحكم الصوت
// //   final ValueNotifier<double> sfxVolume = ValueNotifier(1.0);

// //   bool _bgmPlaying = false;

// //   void _applyVolume() async {
// //     // _bgmPlayer.setVolume(bgmVolume.value);
// //     // _sfxPlayer.setVolume(sfxVolume.value);

// //     await _bgmPlayer.setVolume(bgmVolume.value);
// //   }

// //   /// 🎵 موسيقى الخلفية
// //   Future<void> playBgm(String path) async {
// //     if (_bgmPlaying) return;

// //     await _bgmPlayer.setVolume(bgmVolume.value); // 🔥 قبل التشغيل
// //     await _bgmPlayer.setReleaseMode(ReleaseMode.loop); // 🔥 خليها loop أحسن
// //     await _bgmPlayer.play(AssetSource(path));

// //     _bgmPlaying = true;
// //   }

// //   Future<void> stopBgm() async {
// //     await _bgmPlayer.stop();
// //     _bgmPlaying = false;
// //   }
// //   // stopEarthCracked

// //   /// 🔊 مؤثرات صوتية
// //   Future<void> playSfx(String path) async {
// //     await _sfxPlayer.stop(); // optional
// //     await _sfxPlayer.setVolume(sfxVolume.value);
// //     await _sfxPlayer.play(AssetSource(path));
// //   }

// //   Future<void> stopSfx() async => await _bgmPlayer.stop();

// //   // 🎯 اختصارات جاهزة
// //   void correct() => playSfx('sound/true.aac');
// //   void wrong() => playSfx('sound/false.mp3');
// //   void drag() => playSfx('sound/drag.mp3');
// //   void click() => playSfx('sound/click.aac');
// //   // void iron() => playSfx('sound/iron.mp3');
// //   // void ironFall() => playSfx('sound/iron_fall.mp3');
// //   // void closeTheBox() => playSfx('sound/iron_fall.mp3');
// //   // void sandFlow() => playSfx('sound/sand_flow.mp3');
// //   // void waterAndBird() => playSfx('sound/water_and_bird.mp3');
// //   // void closeBox() => playSfx('sound/close_box.mp3');
// //   // void openDoor3() => playSfx('sound/Open_door3.mp3');
// //   // void stones() => playSfx('sound/stones.mp3');
// //   // void openDoor() => playSfx('sound/Open_door.mp3');
// //   // void effectOpenDoor() => playSfx('sound/effect_open_door.mp3');
// //   // void doorMakbara() => playSfx('sound/Door_makbara.mp3');
// //   // void openLamp() => playSfx('sound/Open_lamp.mp3');
// //   // void openCoffin() => playSfx('sound/Open_coffin.mp3');
// //   // void earthCracked() => playSfx('sound/Earth_cracked.mp3');
// //   // void falling() => playSfx('sound/Falling.mp3');
// // }
// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/foundation.dart';

// class SoundManager {
//   SoundManager._internal() {
//     bgmVolume.addListener(_applyVolume);
//     sfxVolume.addListener(_applyVolume);
//   }

//   static final SoundManager instance = SoundManager._internal();

//   final AudioPlayer _bgmPlayer = AudioPlayer();
//   final AudioPlayer _sfxPlayer = AudioPlayer();

//   final ValueNotifier<double> bgmVolume = ValueNotifier(1.0);
//   final ValueNotifier<double> sfxVolume = ValueNotifier(1.0);

//   bool _isPlaying = false;
//   bool _isPaused = false;
//   String? _currentBgm;

//   void _applyVolume() {
//     _bgmPlayer.setVolume(bgmVolume.value);
//     _sfxPlayer.setVolume(sfxVolume.value);
//   }

//   // 🎵 تشغيل الخلفية
//   Future<void> playBgm(String path) async {
//     try {
//       if (_currentBgm == path && _isPlaying) return;

//       await _bgmPlayer.stop();

//       await _bgmPlayer.setReleaseMode(ReleaseMode.stop); // 🔥 مهم
//       await _bgmPlayer.setVolume(bgmVolume.value);
//       await _bgmPlayer.play(AssetSource(path));

//       _currentBgm = path;
//       _isPlaying = true;
//       _isPaused = false;
//     } catch (e) {
//       debugPrint("BGM ERROR: $e");
//     }
//   }

//   // ⏸️ pause
//   Future<void> pauseBgm() async {
//     try {
//       if (!_isPlaying || _isPaused) return;

//       await _bgmPlayer.pause();
//       _isPaused = true;
//     } catch (e) {
//       debugPrint("PAUSE ERROR: $e");
//     }
//   }

//   // ▶️ resume
//   Future<void> resumeBgm() async {
//     try {
//       if (!_isPaused) return;

//       await _bgmPlayer.resume();
//       _isPaused = false;
//     } catch (e) {
//       debugPrint("RESUME ERROR: $e");
//     }
//   }

//   // ⛔ stop
//   Future<void> stopBgm() async {
//     try {
//       await _bgmPlayer.stop();
//       _isPlaying = false;
//       _isPaused = false;
//       _currentBgm = null;
//     } catch (e) {
//       debugPrint("STOP ERROR: $e");
//     }
//   }

//   // 🔊 SFX
//   Future<void> playSfx(String path) async {
//     try {
//       final player = AudioPlayer(); // 🔥 new instance

//       await player.setReleaseMode(ReleaseMode.stop);
//       await player.setVolume(sfxVolume.value);

//       await player.play(AssetSource(path));

//       // 🧹 تنظيف بعد ما يخلص
//       player.onPlayerComplete.listen((event) {
//         player.dispose();
//       });
//     } catch (e) {
//       debugPrint("SFX ERROR: $e");
//     }
//   }

//   void click() => playSfx('sound/click.aac');
//   void correct() => playSfx('sound/true.aac');
//   void wrong() => playSfx('sound/false.mp3');
//   void drag() => playSfx('sound/drag.mp3');
// }
class SoundManager {
  SoundManager._internal() {
    bgmVolume.addListener(_applyVolume);
    sfxVolume.addListener(_applyVolume);
  }

  static final SoundManager instance = SoundManager._internal();

  final AudioPlayer _bgmPlayer = AudioPlayer();

  // 🔥 Player ثابت للـ drag
  final AudioPlayer _dragPlayer = AudioPlayer();

  final ValueNotifier<double> bgmVolume = ValueNotifier(1.0);
  final ValueNotifier<double> sfxVolume = ValueNotifier(1.0);

  bool _isPlaying = false;
  bool _isPaused = false;
  String? _currentBgm;

  bool _dragPlaying = false; // 🔥 يمنع التكرار

  void _applyVolume() {
    _bgmPlayer.setVolume(bgmVolume.value);
    _dragPlayer.setVolume(sfxVolume.value);
  }

  // 🎵 BGM
  Future<void> playBgm(String path) async {
    try {
      if (_currentBgm == path && _isPlaying) return;

      await _bgmPlayer.stop();
      await _bgmPlayer.setVolume(bgmVolume.value);
      await _bgmPlayer.play(AssetSource(path));

      _currentBgm = path;
      _isPlaying = true;
      _isPaused = false;
    } catch (e) {
      debugPrint("BGM ERROR: $e");
    }
  }

  Future<void> pauseBgm() async {
    if (!_isPlaying || _isPaused) return;
    await _bgmPlayer.pause();
    _isPaused = true;
  }

  Future<void> resumeBgm() async {
    if (!_isPaused) return;
    await _bgmPlayer.resume();
    _isPaused = false;
  }

  Future<void> stopBgm() async {
    await _bgmPlayer.stop();
    _isPlaying = false;
    _isPaused = false;
    _currentBgm = null;
  }

  // 🔊 SFX عادي
  Future<void> playSfx(String path) async {
    try {
      final player = AudioPlayer();

      await player.setVolume(sfxVolume.value);
      await player.play(AssetSource(path));

      player.onPlayerComplete.listen((event) {
        player.dispose();
      });
    } catch (e) {
      debugPrint("SFX ERROR: $e");
    }
  }

  // 🔥 DRAG FIX الحقيقي
  bool _dragLocked = false;
  DateTime _lastDragTime = DateTime.now();

  Future<void> playDrag() async {
    final now = DateTime.now();

    // ⛔ منع السبام بالوقت
    if (now.difference(_lastDragTime) < const Duration(milliseconds: 100)) {
      return;
    }

    // ⛔ لو في عملية شغالة بالفعل
    if (_dragLocked) return;

    _dragLocked = true;
    _lastDragTime = now;

    try {
      await _dragPlayer.stop();

      await _dragPlayer.setVolume(sfxVolume.value);

      // 🔥 مهم: setSource قبل play في بعض الأجهزة
      await _dragPlayer.setSource(AssetSource('sound/click.aac'));
      await _dragPlayer.resume();
    } catch (e) {
      debugPrint("DRAG ERROR: $e");
    }

    _dragLocked = false;
  }

  void click() => playSfx('sound/click.aac');
  void correct() => playSfx('sound/true.aac');
  void wrong() => playSfx('sound/false.mp3');
}
// bool _isDragLooping = false;

// Future<void> startDrag() async {
//   if (_isDragLooping) return;

//   _isDragLooping = true;

//   try {
//     await _dragPlayer.stop();

//     await _dragPlayer.setReleaseMode(ReleaseMode.loop); // 🔥 looping
//     await _dragPlayer.setVolume(sfxVolume.value);

//     await _dragPlayer.play(AssetSource('sound/drag.mp3'));
//   } catch (e) {
//     debugPrint("DRAG START ERROR: $e");
//   }
// }

// Future<void> stopDrag() async {
//   if (!_isDragLooping) return;

//   try {
//     await _dragPlayer.stop();
//   } catch (e) {
//     debugPrint("DRAG STOP ERROR: $e");
//   }

//   _isDragLooping = false;
// }
