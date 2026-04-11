import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myhabits/Core/Font.dart';
import 'package:myhabits/Core/constants.dart';
import 'package:myhabits/Core/Images&colors.dart';

class DevelopersScreen extends StatelessWidget {
  const DevelopersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return
    // GameScreenTwo(
    Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          //           // 🎨 الخلفية
          SizedBox.expand(
            child: Image.asset(AppImages.developerscreen, fit: BoxFit.fill),
          ),

          Positioned(
            // top: 0, left: 100,
            child: BodyOfDevScreen(),
          ),
          Positioned(
            top: MediaQuery.sizeOf(context).height * .3,
            child: Image.asset(
              AppImages.development,
              width: 360.w,
              height: 360.w,
            ),
          ),
          LeftButtonTwo(),
        ],
      ),
      //    // );
    );
  }
}

class BodyOfDevScreen extends StatelessWidget {
  const BodyOfDevScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.amber,
      // width: 1780.w,
      // height: 1100.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            textAlign: TextAlign.center,
            "هذه اللعبة جزء من مشروع التخرج لسنه 2026/2025 \n لطلاب جامعة عين شمس كلية التربية النوعية قسم تكنولوجيا شعبة معلم حاسب",
            style: getRegulerTextStyle(
              fontSize: 40.sp,
              context: context,
              color: AppColors.mainColor,
            ),
          ),
          //عمل الطلاب
          Text(
            textAlign: TextAlign.center,
            ":عمل الطلاب",
            style: getBoldTextStyle(
              context: context,
              fontSize: 45.sp,
              color: Colors.black,
            ),
          ),

          //الكتور
          Container(
            // color: Colo  rs.red,
            width: MediaQuery.sizeOf(context).width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      "يوسف عماد جعروج -",
                      style: getMediumTextStyle(
                        fontSize: 40.sp,
                        context: context,
                        // color: AppColors.mainColor,
                      ),
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      "يوسف محمد ناصر -",
                      style: getMediumTextStyle(
                        fontSize: 40.sp,
                        context: context,
                        // color: AppColors.mainColor,
                      ),
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      "مؤمن عصام حسن -",
                      style: getMediumTextStyle(
                        fontSize: 40.sp,
                        context: context,
                        // color: AppColors.mainColor,
                      ),
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      "محمد حسن السيد -",
                      style: getMediumTextStyle(
                        fontSize: 40.sp,
                        context: context,
                        // color: AppColors.mainColor,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      // textAlign: TextAlign.center,
                      "وصال محمد علي -",
                      style: getMediumTextStyle(
                        fontSize: 40.sp,
                        context: context,
                        // color: AppColors.mainColor,
                      ),
                    ),
                    Text(
                      // textAlign: TextAlign.center,
                      "هاجر جارحي حلمي -",
                      style: getMediumTextStyle(
                        fontSize: 40.sp,
                        context: context,
                        // color: AppColors.mainColor,
                      ),
                    ),
                    Text(
                      // textAlign: TextAlign.center,
                      "مارتينا ناجي ناشد -",
                      style: getMediumTextStyle(
                        fontSize: 40.sp,
                        context: context,
                        // color: AppColors.mainColor,
                      ),
                    ),
                    Text(
                      // textAlign: TextAlign.center,
                      "بسنت طارق السيد -",
                      style: getMediumTextStyle(
                        fontSize: 40.sp,
                        context: context,
                        // color: AppColors.mainColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          //            ":تحت اشراف ",
          Text(
            textAlign: TextAlign.center,
            ":تحت اشراف ",
            style: getBoldTextStyle(
              context: context,
              fontSize: 50.sp,
              color: Colors.black,
            ),
          ),

          //الكتور
          Container(
            width: MediaQuery.sizeOf(context).width,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  "د/احمد مكاوي",
                  style: getMediumTextStyle(
                    fontSize: 50.sp,
                    context: context,
                    // color: AppColors.mainColor,
                  ),
                ),
                Text(
                  textAlign: TextAlign.center,
                  "د/هنادي انور ",
                  style: getMediumTextStyle(
                    fontSize: 50.sp,
                    context: context,
                    // color: AppColors.mainColor,
                  ),
                ),
              ],
            ),
          ),

          // 🎨 الاعدادات
          // LeftButton(),
        ],
      ),
    );
  }
}
