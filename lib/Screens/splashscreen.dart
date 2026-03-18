import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myhabits/Core/Font.dart';
import 'package:myhabits/Core/Routes.dart';
import 'package:myhabits/Core/animation_restart_mixin.dart';
import 'package:myhabits/Core/soundManger.dart';
import 'package:myhabits/main.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:myhabits/Core/Images&colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin, RestartableAnimations {
  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    // 🔊 تشغيل صوت التحميل
    SoundManager.instance.playBgm('sound/loading.mp3');

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 6000),
    );

    _fade = Tween<double>(
      begin: 0.1,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _scale = Tween<double>(
      begin: 0.1,
      end: 1.2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.forward(from: 0);

    // ⏱️ الانتقال بعد الأنيميشن
    Future.delayed(const Duration(milliseconds: 8000), () {
      Navigator.pushReplacementNamed(
        context,
        // userisLoggedin ? Routes.levelMapScreen : Routes.homeScreen,
        userisLoggedin ? Routes.homeScreen : Routes.instructions,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // 🖼️ الخلفية
          SizedBox.expand(
            child: Image.asset(AppImages.splash, fit: BoxFit.fill),
          ),

          // ✨ الأنيميشن
          Center(
            child: FadeTransition(
              opacity: _fade,
              child: ScaleTransition(
                scale: _scale,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3.5,
                      child: LinearPercentIndicator(
                        backgroundColor: Colors.black54,
                        progressColor: const Color(0xFFEbe660c),
                        animation: true,
                        percent: 1.0,
                        animationDuration: 5000,
                        lineHeight: 10,
                        barRadius: const Radius.circular(10),
                      ),
                    ),
                    Text(
                      '....  انتظر التحميل',

                      style: getArabLightTextStyle(
                        context: context,
                        color: AppColors.secondColor,
                        fontSize: 40.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
