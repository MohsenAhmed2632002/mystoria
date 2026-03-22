// lib/screens/feedback_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myhabits/Core/Images&colors.dart';

class FeedbackScreen extends StatelessWidget {
  final bool isCorrect;
  final int stars;
  final int helps;
  final int timeLeft;
  final VoidCallback? onNext;
  final VoidCallback? onRetry;
  final VoidCallback? onExit;

  const FeedbackScreen({
    super.key,
    required this.isCorrect,
    this.stars = 0,
    required this.helps,
    required this.timeLeft,
    this.onNext,
    this.onRetry,
    this.onExit,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // الخلفية (يمكن أن تكون صورة أو لون)
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.background_Awards), // استخدم خلفية مناسبة
                fit: BoxFit.cover,
              ),
            ),
          ),

          // المحتوى مع إمكانية التمرير في حالة overflow
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 100.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // عنوان النتيجة
                  Text(
                    isCorrect ? '✅ تمت الإجابة بشكل صحيح' : '❌ إجابة خاطئة',
                    style: TextStyle(
                      fontSize: 80.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          offset: Offset(2, 2),
                          blurRadius: 4,
                          color: Colors.black54,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 50.h),

                  // الوقت المستغرق
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "$timeLeft ث",
                        style: TextStyle(
                          fontSize: 60.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        "الوقت المستغرق:",
                        style: TextStyle(
                          fontSize: 60.sp,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),

                  // عدد المحاولات
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "$helps",
                        style: TextStyle(
                          fontSize: 60.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        "عدد المحاولات:",
                        style: TextStyle(
                          fontSize: 60.sp,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),

                  // النجوم (إذا كانت الإجابة صحيحة)
                  if (isCorrect)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _StarRow(stars: stars),
                        SizedBox(width: 10.w),
                        Text(
                          "النجوم:",
                          style: TextStyle(
                            fontSize: 60.sp,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: 60.h),

                  // الأزرار
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildButton(
                        imagePath: AppImages.exit,
                        onTap: onExit,
                        label: 'خروج',
                      ),
                      SizedBox(width: 40.w),
                      _buildButton(
                        imagePath: AppImages.retry,
                        onTap: onRetry,
                        label: 'إعادة',
                      ),
                      if (isCorrect) ...[
                        SizedBox(width: 40.w),
                        _buildButton(
                          imagePath: AppImages.next1,
                          onTap: onNext,
                          label: 'التالي',
                        ),
                      ],
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

  Widget _buildButton({
    required String imagePath,
    VoidCallback? onTap,
    required String label,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(
            imagePath,
            width: 150.w,
            height: 150.h,
          ),
          SizedBox(height: 10.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 40.sp,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _StarRow extends StatelessWidget {
  final int stars;
  const _StarRow({required this.stars});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Icon(
            index < stars ? Icons.star : Icons.star_border,
            color: index < stars ? Colors.amber : Colors.white70,
            size: 80.sp,
          ),
        );
      }),
    );
  }
}