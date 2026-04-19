import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mystoria/Core/Font.dart';
import 'package:mystoria/Core/Images&colors.dart';
import 'package:mystoria/cubit/Gamecubit/game_cubit.dart';

class AwardScreen extends StatelessWidget {
  const AwardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stars = context.watch<GameCubit>().state.theGame.stars;
    return Scaffold(
      body: Stack(
        children: [
          /// الخلفية
          SizedBox.expand(
            child: Image.asset(AppImages.background_Awards, fit: BoxFit.cover),
          ),

          Positioned(
            top: 150.h,
            left: 400.w,
            child: Container(
              width: 1100.w,
              height: 800.h,
              // color: AppColors.blueColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'الجوائز',
                    style: getBoldTextStyle(
                      context: context,
                      fontSize: 50.sp,
                      color: AppColors.mainColor,
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        stars >= 90 ? AppImages.level_3 : AppImages.darklevel_3,

                        width: 300.w,
                        height: 600.h,
                      ),

                      Image.asset(
                        stars >= 60 ? AppImages.level_2 : AppImages.darklevel_2,

                        width: 300.w,
                        height: 600.h,
                      ),

                      Image.asset(
                        stars >= 30 ? AppImages.level_1 : AppImages.darklevel_1,

                        width: 300.w,
                        height: 600.h,
                      ),
                    ],
                  ),
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
                AppImages.previous,
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
