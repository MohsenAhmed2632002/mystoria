import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mystoria/Core/Routes.dart';
import 'package:mystoria/Core/SharedPre.dart';
import 'package:mystoria/Models/QuestionModel.dart';
import 'package:mystoria/cubit/Gamecubit/game_cubit.dart';
import 'package:mystoria/cubit/Gamecubit/game_state.dart';
import 'package:mystoria/cubit/Playercubit/Playercubit.dart';

bool userisLoggedin = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PlayerStorage.initSharedPreferences(); // ✅ لازم await

  // ✅ تحميل النجوم المحفوظة
  final savedStars = await PlayerStorage.loadStars();

  // ✅ إنشاء الـ Cubit مرة واحدة
  final gameCubit = GameCubit(levels: gameLevels);

  // ✅ تحديث النجوم المحفوظة
  gameCubit.emit(
    GamePlaying(gameCubit.state.theGame.copyWith(stars: savedStars)),
  );
  final user = await PlayerStorage.getPlayer();
  userisLoggedin = user != null && user.name.isNotEmpty;

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PlayerCubit()..loadPlayer()),

        BlocProvider(create: (_) => GameCubit(levels: gameLevels)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1920, 1080),

      child: MaterialApp(
        onGenerateRoute: RoutesGenerator.getRoutes,
        initialRoute: Routes.splashRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
