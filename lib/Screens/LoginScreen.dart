import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myhabits/Core/Font.dart';
import 'package:myhabits/Core/Routes.dart';
import 'package:myhabits/Core/constants.dart';
import 'package:myhabits/Models/PlayerModel.dart';
import 'package:myhabits/cubit/Playercubit/Playercubit.dart';
import 'package:myhabits/Core/Images&colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _GestState();
}

class _GestState extends State<LoginScreen> {
  final TextEditingController _nameController = TextEditingController();
  String selectedAvatar = 'character_boy'; // افتراضي

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // 🎨 الخلفية
          SizedBox.expand(
            child: Image.asset(AppImages.loginscreen, fit: BoxFit.fill),
          ),
          // 🧩 المحتوى
          SingleChildScrollView(
            child: Container(
              // color: Colors.yellow,
              height: MediaQuery.sizeOf(context).height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'تسجيل الدخول',
                    style: getRegulerTextStyle(
                      context: context,
                      fontSize: 40,
                      color: Colors.brown,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  // الاسم
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.5,

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      children: [
                        SizedBox(
                          width: 650.w,
                          // height: 100.h,
                          child: TextField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(25),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              hintText: 'ادخل اسمك',
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          ':الاسم',
                          style: getMediumTextStyle(
                            fontSize: 50.sp,
                            context: context,
                            color: AppColors.mainColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40.h),
                  // اختيار الشخصية
                  Container(
                    // color: Colors.amber,
                    width: MediaQuery.sizeOf(context).width * 0.5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _avatar('girl'),
                        // const SizedBox(width: 20),
                        _avatar('boy'),
                        Text(
                          ':النوع',
                          style: getMediumTextStyle(
                            fontSize: 50.sp,
                            context: context,
                            color: AppColors.mainColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(height: 20.h),
                  GameButton(
                    text: 'تسجيل الدخول',
                    onPressed: () {
                      if (_nameController.text.isEmpty) return;
                      context.read<PlayerCubit>().setPlayer(
                        PlayerModel(
                          name: _nameController.text,
                          avatar: selectedAvatar,
                        ),
                      );
                      // PlayerStorage.setPlayer(
                      //   PlayerModel(
                      //     name: _nameController.text,
                      //     avatar: selectedAvatar,
                      //   ),
                      // );

                      Navigator.pushReplacementNamed(
                        context,
                        Routes.homeScreen,
                      );
                    },
                    fromWidth: 500,
                    fromHeight: 150,
                  ),
                ],
              ),
            ),
          ),
          DevAndSettingIcon(),
          // 🎨 الاعدادات
          // TopLogo(),
          // LeftButton(),
        ],
      ),
    );
  }

  Widget _avatar(String avatarPic) {
    final isSelected = selectedAvatar == avatarPic;

    return GestureDetector(
      onTap: () {
        setState(() => selectedAvatar = avatarPic);
      },
      child: AnimatedScale(
        scale: isSelected ? 1.2 : 1.0,
        duration: const Duration(milliseconds: 150),
        child: Container(
          width: 170.w,
          height: 230.h,
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? Colors.brown : Colors.transparent,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Image.asset('assets/images/$avatarPic.png', width: 50),
        ),
      ),
    );
  }
}
