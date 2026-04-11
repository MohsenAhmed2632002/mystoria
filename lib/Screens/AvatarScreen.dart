import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myhabits/Core/Font.dart';
import 'package:myhabits/Core/Images&colors.dart';
import 'package:myhabits/Core/Routes.dart';
import 'package:myhabits/Models/PlayerModel.dart';
import 'package:myhabits/cubit/Gamecubit/game_cubit.dart';
import 'package:myhabits/cubit/Gamecubit/game_state.dart';
import 'package:myhabits/cubit/Playercubit/Playercubit.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class AvatarScreen extends StatelessWidget {
  const AvatarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// الخلفية
          SizedBox.expand(
            child: Image.asset(AppImages.backgroundAvatar, fit: BoxFit.fill),
          ),

          Positioned(
            top: 100.h,
            left: 100.w,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.settingScreen);
                  },
                  child: Image.asset(
                    AppImages.setting,
                    width: 125.w,
                    height: 125.h,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.developersScreen);
                  },
                  child: Image.asset(
                    AppImages.development,
                    height: 150.h,
                    width: 150.w,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.awardScreen);
                  },
                  child: Image.asset(
                    AppImages.award,
                    width: 125.w,
                    height: 125.h,
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            top: MediaQuery.sizeOf(context).height * 0.2,
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              height: 800.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BlocBuilder<PlayerCubit, PlayerModel?>(
                    builder: (context, player) {
                      if (player == null) {
                        return const SizedBox(); // أو Loader
                      }
                      return Image.asset(
                        'assets/images/character_${player.avatar}.png',
                        height: 650.h,
                        width: 350.w,
                      );
                    },
                  ),
                  UserDate(),
                ],
              ),
            ),
          ),

          Positioned(
            top: 900.h,
            right: 900.w,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(
                'assets/images/previous.png',
                width: 175.w,
                height: 175.h,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UserDate extends StatelessWidget {
  const UserDate({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BlocBuilder<PlayerCubit, PlayerModel?>(
          builder: (context, player) {
            if (player == null) {
              return const SizedBox(); // أو Loader
            }
            // هنا بنعرض اسم اللاعب
            return Container(
              // color: Colors.white.withOpacity(0.7), // خلفية بيضاء شفافة
              // width:
              // MediaQuery.sizeOf(context).width *
              // 0.3, // حدد العرض اللي يناسب تصميمك
              child: Text(
                player.name,
                style: getRegulerTextStyle(
                  context: context,
                  color: Colors.black,
                  fontSize: 50.sp,
                ),
              ),
            );
          },
        ),
        SizedBox(
          width: 300.w, // حدد العرض اللي يناسب تصميمك
          child: Divider(
            color: const Color(0xFF7C4E00),
            indent: 0, // قلل القيم دي شوية للتجربة
            endIndent: 10.w,
            thickness: 3,
            height: 10.h,
          ),
        ),
        BlocBuilder<GameCubit, GameState>(
          builder: (BuildContext context, GameState state) {
            return Row(
              children: [
                Stack(
                  alignment: AlignmentGeometry.centerRight,
                  children: [
                    Image.asset(
                      AppImages.question,
                      width: 250.w,
                      height: 200.h,
                    ),
                    Positioned(
                      right: 50.w,

                      child: Text(
                        "${BlocProvider.of<GameCubit>(context).state.theGame.currentPuzzle + 1}",
                        style: getRegulerTextStyle(
                          context: context,
                          fontSize: 60.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  alignment: AlignmentGeometry.centerRight,
                  children: [
                    Image.asset(AppImages.level, width: 250.w, height: 200.h),
                    Positioned(
                      right: 50.w,

                      child: Text(
                        "${BlocProvider.of<GameCubit>(context).state.theGame.currentLevel + 1}",
                        style: getRegulerTextStyle(
                          context: context,
                          fontSize: 60.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  alignment: AlignmentGeometry.centerRight,
                  children: [
                    Image.asset(
                      AppImages.staravatar,
                      width: 250.w,
                      height: 200.h,
                    ),
                    Positioned(
                      right: 50.w,

                      child: Text(
                        "${context.watch<GameCubit>().state.theGame.stars}",
                        style: getRegulerTextStyle(
                          context: context,
                          fontSize: 60.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
        Row(
          children: [
            SizedBox(
              width:
                  1.sw /
                  3, // استخدام ScreenUtil عشان العرض يبقى متناسق (ثلث الشاشة)
              child: BlocBuilder<GameCubit, GameState>(
                builder: (context, state) {
                  // حساب النسبة المئوية: اللغز الحالي + 1 مقسوم على إجمالي الألغاز
                  // استخدمت .clamp عشان أضمن إن القيمة متخرجش بره نطاق (0.0 لـ 1.0)
                  double progress =
                      (BlocProvider.of<GameCubit>(
                            context,
                          ).state.theGame.currentPuzzle +
                          1) /
                      10;

                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black, // لون البوردر
                        width: 3.w, // عرض البوردر
                      ),
                      borderRadius: BorderRadius.circular(
                        50.r,
                      ), // نفس نصف قطر الشريط
                    ),
                    child: LinearPercentIndicator(
                      // fillColor: const Color(0xFFFFD700),
                      backgroundColor: Colors.transparent,
                      progressColor: const Color(0xFF7C4E00),
                      animation: true,
                      percent: progress.clamp(0.0, 1.0),
                      animationDuration:
                          1000, // خليتها ثانية واحدة عشان تبقى أسرع وألطف
                      lineHeight: 40.h,
                      barRadius: const Radius.circular(10),
                      // ممكن تضيف نص يظهر النسبة المئوية جوه الشريط لو تحب
                      // center: Text(
                      //   "${(progress * 100).toInt()}%",
                      //   style: getRegulerTextStyle(context: context),
                      // ),
                    ),
                  );
                },
              ),
            ),
            Stack(
              alignment: AlignmentGeometry.center,
              children: [
                Image.asset(AppImages.levels, width: 300.w, height: 300.h),
                Text(
                  " مرحلة :${BlocProvider.of<GameCubit>(context).state.theGame.currentLevel + 1}",
                  style: getRegulerTextStyle(context: context, fontSize: 45.sp),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
