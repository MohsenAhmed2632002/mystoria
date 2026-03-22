import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myhabits/Core/Font.dart';
import 'package:myhabits/Core/Images&colors.dart';
import 'package:myhabits/Core/Routes.dart';
import 'package:myhabits/cubit/Gamecubit/game_cubit.dart';

class HintScreen extends StatefulWidget {
  const HintScreen({
    super.key,
    required this.hint,
  }); // استلامه في الـ Constructor
  final String hint;
  @override
  State<HintScreen> createState() => _HintScreenState();
}

class _HintScreenState extends State<HintScreen> {
  // تعريف المتغير
  @override
  Widget build(BuildContext context) {
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
              child: Container(
                // height: 500.h,
                // padding: EdgeInsets.all(30.w),
                // decoration: BoxDecoration(
                // image: DecorationImage(image: AssetImage(AppImages.dialog_2)),
                // borderRadius: BorderRadius.circular(30),
                // ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "دليل من التاريخ",
                        style: getRegulerTextStyle(
                          context: context,
                          color: AppColors.mainColor,
                          fontSize: 96.sp,
                        ),
                      ),
                      Text(
                        widget.hint,
                        style: getRegulerTextStyle(
                          context: context,
                          color: Colors.black,
                          fontSize: 50.sp,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // sound.click();

                              BlocProvider.of<GameCubit>(context).stopTimer();
                              Navigator.pushReplacementNamed(
                                context,
                                Routes.homeScreen,
                              );
                            },
                            child: Image.asset(
                              'assets/images/home.png',
                              width: 150.w,
                              height: 150.h,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              BlocProvider.of<GameCubit>(
                                context,
                              ).startTimer(context);
                              Navigator.pop(context);
                            },
                            child: Image.asset(
                              AppImages.next1,
                              width: 200.w,
                              height: 200.h,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // BackButton(),
        ],
      ),
    );
  }
}

class BackButton extends StatelessWidget {
  const BackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 900.h,
      right: 900.w,
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Image.asset(AppImages.previous, width: 175.w, height: 175.h),
      ),
    );
  }
}
