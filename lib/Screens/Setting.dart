import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mystoria/Core/Font.dart';
import 'package:mystoria/Core/Images&colors.dart';
import 'package:mystoria/Core/Routes.dart';
import 'package:mystoria/Core/constants.dart';
import 'package:mystoria/Core/soundManger.dart';

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
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'الإعدادات',
                style: getRegulerTextStyle(
                  fontSize: 60.sp,
                  context: context,
                  color: AppColors.mainColor,
                ),
              ),
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
                      onChanged: (v) async {
                        sound.bgmVolume.value = v;

                        SoundManager.instance.bgmVolume.value = v;

                        sound.click(); // تجربة فورية
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

                        SoundManager.instance.sfxVolume.value = v;

                        sound.click(); // تجربة فورية
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
                      SoundManager.instance.click();
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
                      SoundManager.instance.click();
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
