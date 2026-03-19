import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myhabits/Core/Images&colors.dart';
import 'package:myhabits/Models/LevelsModel.dart';
import 'package:myhabits/cubit/Gamecubit/game_cubit.dart';

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
            right: 100.w,
            child: Row(
              children: [
                Image.asset(
                  // stars >= 30 ?
                  //  AppImages.track1 :
                  AppImages.track_1dark,
                  width: 650.w,
                  height: 200.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
