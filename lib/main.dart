import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myhabits/Core/Routes.dart';
import 'package:myhabits/Core/SharedPre.dart';
import 'package:myhabits/Models/LevelsModel.dart';
import 'package:myhabits/cubit/Gamecubit/game_cubit.dart';
import 'package:myhabits/cubit/Playercubit/Playercubit.dart';

// الهارون
// بطل العالم
// قصص الانبياء
// دكتن شحاته و حلاوة روح
// عبدو موته الالمماني
// MOSTAFAasdf@1133

bool userisLoggedin = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PlayerStorage.initSharedPreferences(); // ✅ لازم await

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
