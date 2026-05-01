import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mystoria/Core/Font.dart';
import 'package:mystoria/Core/Images&colors.dart';
import 'package:mystoria/Core/constants.dart';
import 'package:mystoria/Core/soundManger.dart';
import 'package:mystoria/cubit/Gamecubit/game_cubit.dart';

class EscScreen extends StatelessWidget {
  const EscScreen({super.key});

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'تأكيد الخروج',
                    style: getBoldTextStyle(
                      context: context,
                      fontSize: 70.sp,
                      color: AppColors.mainColor,
                    ),
                  ),
                  Text(
                    'هل تريد الخروج من اللعبة؟',
                    style: getBoldTextStyle(
                      context: context,
                      fontSize: 50.sp,
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GameButton(
                        text: "لا",
                        onPressed: () {
                          SoundManager.instance.click();
                          Navigator.pop(context);
                        },
                        fromWidth: 500,
                        fromHeight: 150,
                      ),
                      GameButton(
                        text: "نعم",
                        onPressed: () {
                          SoundManager.instance.click();
                          SystemNavigator.pop();
                        },
                        fromWidth: 500,
                        fromHeight: 150,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
