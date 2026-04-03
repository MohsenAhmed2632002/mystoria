import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myhabits/Core/Font.dart';
import 'package:myhabits/Core/Images&colors.dart';
import 'package:myhabits/Core/constants.dart';
import 'package:myhabits/Core/soundManger.dart';
import 'package:myhabits/Models/TripleModel.Dart';
import 'package:myhabits/Screens/feedackScreen.dart';
import 'package:myhabits/cubit/Gamecubit/game_cubit.dart';

class NetworkQ extends StatefulWidget {
  const NetworkQ({super.key});

  @override
  State<NetworkQ> createState() => _NetworkQState();
}

class _NetworkQState extends State<NetworkQ> {
  /// الإجابة الصحيحة
  final List<TripleItem> correctTriples = [
    TripleItem(
      king: AppImages.zosar,
      family: "الهرم المدرج",
      achievement: AppImages.stepPyramid,
    ),
    TripleItem(
      king: AppImages.khofo,
      family: 'الهرم الاكبر',
      achievement: AppImages.bigPyramid,
    ),
    TripleItem(
      king: AppImages.khafraa,
      family: 'ابو الهول',
      achievement: AppImages.aboAlhawl,
    ),
  ];

  /// العناصر القابلة للسحب
  // late List<TripleItem> draggableItems;

  /// اختيارات المستخدم
  // final Map<int, TripleItem> userTriples = <int, TripleItem>{};

  @override
  Widget build(BuildContext context) {
    return GameScreen(
      color: AppColors.blueColor,
      hint: 'أربط بين الملك و عصره و اثره الشهير',

      background: AppImages.quiz1,
      mediaQueryRight: 0,
      mediaQueryTop: MediaQuery.sizeOf(context).height * 0.05,
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,

        // color: Colors.red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: correctTriples
                  .map<Widget>(
                    (item) => Image.asset(
                      item.achievement,
                      width: 400.w,
                      height: 400.h,
                    ),
                  )
                  .toList(),
            ),

            /// 🔹 Targets (الأبواب)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                correctTriples.length,
                (index) => _buildDoor(index, correctTriples[index].family),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🚪 Door (Target)
  Widget _buildDoor(int index, String familyText) {
    return GameButtonTwo(
      text: correctTriples[index].family,
      onPressed: () => _checkResult(index),
      fontSize: 40,
      fromWidth: 350,
      fromHeight: 125,
    );
  }

  // ✅ التحقق من الحل
  void _checkResult(int index) {
    if (correctTriples[index].family == "الهرم المدرج") {
      SoundManager.instance.correct();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => FeedackScreen(
            isCorrect: true,
            stars: BlocProvider.of<GameCubit>(context).calculateStars(),
            helps: BlocProvider.of<GameCubit>(context).state.theGame.attempts,
            timeLeft: BlocProvider.of<GameCubit>(
              context,
            ).state.theGame.timeLeft,
          ),
        ),
      );
    } else {
      SoundManager.instance.wrong();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => FeedackScreen(
            isCorrect: false,
            stars: 0,
            helps:
                BlocProvider.of<GameCubit>(context).state.theGame.attempts - 1,
            timeLeft: BlocProvider.of<GameCubit>(
              context,
            ).state.theGame.timeLeft,
          ),
        ),
      );
    }
  }
}
