import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myhabits/Core/Font.dart';
import 'package:myhabits/Core/Images&colors.dart';
import 'package:myhabits/Core/Routes.dart';
import 'package:myhabits/Core/constants.dart';
import 'package:myhabits/cubit/Gamecubit/game_cubit.dart';

class FeedackScreen extends StatefulWidget {
  const FeedackScreen({
    super.key,
    required this.isCorrect,
    required this.stars,
    required this.helps,
    required this.timeLeft,
  });

  final bool isCorrect;
  final int stars;
  final int helps;
  final int timeLeft;

  @override
  State<FeedackScreen> createState() => _FeedackScreenState();
}

class _FeedackScreenState extends State<FeedackScreen> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GameCubit>();

    return Scaffold(
      body: Stack(
        children: [
          /// الخلفية
          SizedBox.expand(
            child: Image.asset(AppImages.background_Awards, fit: BoxFit.cover),
          ),

          /// محتوى الصفحة
          Positioned(
            top: 150.h,
            left: 400.w,
            child: Container(
              // color: Colors.red,
              width: 1100.w,
              height: 900.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  /// العنوان
                  Text(
                    widget.isCorrect
                        ? 'تمت انجاز المهمة بنجاح'
                        : '❌ إجابة خاطئة',
                    style: getRegulerTextStyle(
                      context: context,
                      fontSize: 80.sp,
                      color: AppColors.accentColor,
                    ),
                  ),

                  /// الوقت
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${widget.timeLeft} ث ",
                        style: getRegulerTextStyle(
                          context: context,
                          fontSize: 50.sp,
                          color: AppColors.accentColor,
                        ),
                      ),
                      Text(
                        ":الوقت المستغرق ",
                        style: getRegulerTextStyle(
                          context: context,
                          fontSize: 50.sp,
                          color: AppColors.accentColor,
                        ),
                      ),
                    ],
                  ),

                  /// المحاولات
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${widget.helps}",
                        style: getRegulerTextStyle(
                          context: context,
                          fontSize: 50.sp,
                          color: AppColors.accentColor,
                        ),
                      ),
                      Text(
                        " :عدد المحاولات ",
                        style: getRegulerTextStyle(
                          context: context,
                          fontSize: 50.sp,
                          color: AppColors.accentColor,
                        ),
                      ),
                    ],
                  ),

                  /// النجوم
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.isCorrect) StarRow(stars: widget.stars),
                      Text(
                        ":النجوم",
                        style: getRegulerTextStyle(
                          context: context,
                          fontSize: 50.sp,
                          color: AppColors.accentColor,
                        ),
                      ),
                    ],
                  ),

                  /// الأزرار
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      /// خروج
                      GestureDetector(
                        onTap: () {
                          cubit.exitGame();
                          Navigator.pushReplacementNamed(
                            context,
                            Routes.homeScreen,
                          );
                        },
                        child: Image.asset(
                          AppImages.exit,
                          width: 200.w,
                          height: 200.h,
                        ),
                      ),

                      // SizedBox(width: 25.w),

                      /// إعادة
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          // cubit.wrongAnswer(context);
                        },
                        child: Image.asset(
                          AppImages.retry,
                          width: 200.w,
                          height: 200.h,
                        ),
                      ),

                      // SizedBox(width: 25.w),

                      /// التالي
                      GestureDetector(
                        onTap: widget.isCorrect
                            ? () {
                                cubit.correctAnswer(context);
                                Navigator.pop(context);
                              }
                            : null,
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
        ],
      ),
    );
  }
}
