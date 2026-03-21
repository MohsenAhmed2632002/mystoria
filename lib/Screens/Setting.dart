import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myhabits/Core/Font.dart';
import 'package:myhabits/Core/Images&colors.dart';
import 'package:myhabits/Core/Routes.dart';
import 'package:myhabits/Core/constants.dart';
import 'package:myhabits/Core/soundManger.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sound = SoundManager.instance;

    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset(
              'assets/images/setting_screen.png',
              fit: BoxFit.fill,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'الإعدادات',
                style: getRegulerTextStyle(
                  fontSize: 50.sp,
                  context: context,
                  color: AppColors.mainColor,
                ),
              ),

              // /// 🎚️ Slider الصوت
              // ValueListenableBuilder<double>(
              //   valueListenable: sound.volume,
              //   builder: (context, volume, _) {
              //     return Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         SizedBox(
              //           width: 900.w,
              //           child: Slider(
              //             value: volume,
              //             min: 0,
              //             max: 1,
              //             divisions: 10,
              //             onChanged: (value) {
              //               sound.volume.value = value;
              //               // sound.click(); // 🔊 تكه خفيفة
              //             },
              //           ),
              //         ),
              //         Image.asset(
              //           'assets/images/sound.png',
              //           width: 130.w,
              //           height: 130.h,
              //         ),
              //       ],
              //     );
              //   },
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Text('موسيقى الخلفية'),
                  Image.asset(
                    'assets/images/sound.png',
                    width: 130.w,
                    height: 130.h,
                  ),
                ],
              ),
              ValueListenableBuilder<double>(
                valueListenable: sound.bgmVolume,
                builder: (context, value, _) {
                  return SizedBox(
                    width: 900.w,

                    child: Slider(
                      value: value,
                      min: 0,
                      max: 1,
                      divisions: 10,
                      onChanged: (v) {
                        sound.bgmVolume.value = v;
                      },
                    ),
                  );
                },
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Text('المؤثرات الصوتية'),
                  Image.asset(
                    'assets/images/sound.png',
                    width: 130.w,
                    height: 130.h,
                  ),
                ],
              ),
              // SizedBox(height: 40),

              //               /// 🔊 المؤثرات الصوتية
              ValueListenableBuilder<double>(
                valueListenable: sound.sfxVolume,
                builder: (context, value, _) {
                  return SizedBox(
                    width: 900.w,

                    child: Slider(
                      value: value,
                      min: 0,
                      max: 1,
                      divisions: 10,
                      onChanged: (v) {
                        sound.sfxVolume.value = v;
                        // sound.click(); // تجربة فورية
                      },
                    ),
                  );
                },
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      // sound.click();
                      Navigator.pushReplacementNamed(
                        context,
                        Routes.homeScreen,
                      );
                    },
                    child: Image.asset(
                      'assets/images/home.png',
                      width: 110.w,
                      height: 110.h,
                    ),
                  ),
                  GameButton(
                    text: 'رجوع',
                    onPressed: () {
                      // sound.click();
                      Navigator.pop(context);
                    },
                    fromWidth: 500,
                    fromHeight: 200,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
