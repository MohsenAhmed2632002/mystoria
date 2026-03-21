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
            child: Image.asset(AppImages.award, fit: BoxFit.fill),
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
                    Navigator.pushNamed(context, Routes.settingScreen);
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
