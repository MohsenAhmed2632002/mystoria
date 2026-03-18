import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myhabits/Core/Images&colors.dart';
import 'package:myhabits/Core/animation_restart_mixin.dart';
import 'package:myhabits/Core/constants.dart';
import 'package:myhabits/Core/soundManger.dart';
import 'package:myhabits/Models/PlayerModel.dart';
import 'package:myhabits/Models/QuestionModel.dart';
import 'package:myhabits/cubit/Gamecubit/game_cubit.dart';
import 'package:myhabits/cubit/Playercubit/Playercubit.dart';

class LevelTwoPuzzeleBoat extends StatefulWidget {
  final QuestionModel question;
  const LevelTwoPuzzeleBoat({super.key, required this.question});

  @override
  State<LevelTwoPuzzeleBoat> createState() => _LevelTwoPuzzeleBoatState();
}

class _LevelTwoPuzzeleBoatState extends State<LevelTwoPuzzeleBoat>
     with SingleTickerProviderStateMixin, RestartableAnimations {
  late AnimationController boatController;

  final List<String> correctOrder = [
    AppImages.banner4,
    AppImages.banner3,
    AppImages.banner2,

    AppImages.banner1,
  ];

  List<String> currentOrder = [
    AppImages.banner3,
    AppImages.banner1,
    AppImages.banner4,

    AppImages.banner2,
  ];

  @override
  void initState() {
    super.initState();

    boatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
  
    );
    registerController(boatController);
  }


  // @override
  // void dispose() {
  //   boatController.dispose();
  //   super.dispose();
  // }

  bool checkOrder() {
    for (int i = 0; i < correctOrder.length; i++) {
      if (currentOrder[i] != correctOrder[i]) {
        return false;
      }
    }
    return true;
  }

  void startBoat() async {
    if (checkOrder()) {
      SoundManager.instance.waterAndBird();

      await boatController.forward().then((value) => onCorrect(context));

    } else {
      // SoundManager.instance.wrong();
      //
      context.read<GameCubit>().wrongAnswer(context);

      // setState(() {
      //   currentOrder.shuffle();
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // 🎨 الخلفية
          SizedBox.expand(
            child: Image.asset(widget.question.background, fit: BoxFit.fill),
          ),

          /// القارب
          AnimatedBuilder(
            animation: boatController,
            builder: (context, child) {
              return Positioned(
                bottom: 100.h,

                left: boatController.value * MediaQuery.of(context).size.width,
                child: Image.asset(AppImages.ship, width: 850.w, height: 600.h),
              );
            },
          ),
          // 🎨 الجسم
          Positioned(
            right: MediaQuery.sizeOf(context).width * 0,
            top: MediaQuery.sizeOf(context).height * 0.2,
            child: Container(
              height: MediaQuery.sizeOf(context).height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    // color: AppColors.secondColor,
                    height: MediaQuery.sizeOf(context).height / 2,
                    width: MediaQuery.sizeOf(context).width,
                    child: Column(
                      children: [
                        /// اللوحات
                        Container(
                          height: 350.h,
                          alignment: Alignment.center,
                          child: Center(
                            child: SizedBox(
                              height: 350.h,
                              width: 1200.w, // مساحة التحكم في المنتصف
                              child: ReorderableListView(
                                scrollDirection: Axis.horizontal,
                                onReorder: (oldIndex, newIndex) {
                                  setState(() {
                                    if (newIndex > oldIndex) newIndex--;
                                    final item = currentOrder.removeAt(
                                      oldIndex,
                                    );
                                    currentOrder.insert(newIndex, item);
                                  });
                                },
                                children: [
                                  for (int i = 0; i < currentOrder.length; i++)
                                    Padding(
                                      key: ValueKey(currentOrder[i]),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 20.w,
                                      ),
                                      child: Image.asset(
                                        currentOrder[i],
                                        width: 250.w,
                                        height: 350.h,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        /// زر الانطلاق
                        GameButtonTwo(
                          text: "انطلاق",
                          onPressed: startBoat,
                          fontSize: 35,
                          fromWidth: 400,
                          fromHeight: 150,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 🎨 الأيقونات العلوية
          SettingTryAndClueContainer(hint: "تذكر : كل حضاره ليها بدايه واضحه"),

          Positioned(
            bottom: 200.h,
            left: 10,
            child: BlocBuilder<PlayerCubit, PlayerModel?>(
              builder: (context, player) {
                if (player == null) {
                  return const SizedBox(); // أو Loader
                }

                return Column(
                  children: [
                    Image.asset(
                      'assets/images/${player.avatar}.png',
                      height: 435.h,
                      width: 300.w,
                    ),
                  ],
                );
              },
            ),
          ),
          QustionContainer(
            color: widget.question.color,
          ), // 🎨 الأيقونات العلوية
          StarAndTimeContainer(),

          // ),
        ],
      ),
    );
  }
}
