import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myhabits/Core/Font.dart';
import 'package:myhabits/Core/Routes.dart';
import 'package:myhabits/Core/Images&colors.dart';
import 'package:myhabits/Core/animation_restart_mixin.dart';
import 'package:myhabits/Models/PlayerModel.dart';
import 'package:myhabits/Screens/HomeScreen.dart';
import 'package:myhabits/Screens/Instructions.dart';
import 'package:myhabits/Screens/LoginScreen.dart';
import 'package:myhabits/cubit/Gamecubit/game_cubit.dart';
import 'package:myhabits/cubit/Gamecubit/game_state.dart';
import 'package:myhabits/cubit/Playercubit/Playercubit.dart';
import 'package:myhabits/main.dart';

class GameScreen extends StatelessWidget {
  final String background;
  final Widget child;
  final double mediaQueryRight;
  final double mediaQueryTop;
  final double? characterFromBottom;
  final String hint;
  final Color color;
  const GameScreen({
    super.key,
    this.characterFromBottom,
    required this.background,
    required this.child,
    required this.mediaQueryRight,
    required this.mediaQueryTop,
    required this.hint,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // 🎨 الخلفية
          SizedBox.expand(child: Image.asset(background, fit: BoxFit.fill)),
          // 🎨 الجسم
          Positioned(right: mediaQueryRight, top: mediaQueryTop, child: child),
          // 🎨 الأيقونات العلوية
          CharacterAndClueContainer(hint: hint),

          // CharacterContainer(
          //   frombottom: characterFromBottom,
          // ), // 🎨 الأيقونات العلوية
          QustionContainer(color: color),
          // 🎨 الأيقونات العلوية
          TryAndTimeContainer(),

          // ),
        ],
      ),
    );
  }
}

class GameButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double fromWidth;
  final double fromHeight;
  final TextStyle? textStyle;

  const GameButton({
    super.key,
    required this.text,
    required this.onPressed,

    this.textStyle,
    required this.fromWidth,
    required this.fromHeight,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 🪵 خلفية الزرار
            Image.asset(
              'assets/images/button.png',
              fit: BoxFit.fill,
              width: fromWidth.w,
              height: fromHeight.h,
            ),

            // ✏️ النص
            Text(
              text,
              style: getRegulerTextStyle(
                context: context,
                color: AppColors.mainColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GameButtonLight extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double fromWidth;
  final double fromHeight;
  final TextStyle? textStyle;

  const GameButtonLight({
    super.key,
    required this.text,
    required this.onPressed,

    this.textStyle,
    required this.fromWidth,
    required this.fromHeight,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 🪵 خلفية الزرار
            Image.asset(
              AppImages.buttonLight,
              // fit: BoxFit.cover,
              width: fromWidth.w,
              height: fromHeight.h,
            ),

            // ✏️ النص
            Text(
              text,
              style: getRegulerTextStyle(context: context, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

class GameButtonTwo extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double fromWidth;
  final double fromHeight;
  final TextStyle? textStyle;
  final double fontSize;
  const GameButtonTwo({
    super.key,
    required this.text,
    required this.onPressed,
    required this.fontSize,
    this.textStyle,
    required this.fromWidth,
    required this.fromHeight,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: fromWidth.w,
        height: fromHeight.h,

        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(AppImages.buttongame),
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: getMediumTextStyle(
              fontSize: fontSize.sp,
              context: context,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

class GameButtonThree extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double fromWidth;
  final double fromHeight;
  final TextStyle? textStyle;
  final double fontSize;
  const GameButtonThree({
    super.key,
    required this.text,
    required this.onPressed,
    required this.fontSize,
    this.textStyle,
    required this.fromWidth,
    required this.fromHeight,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: fromWidth.w,
        height: fromHeight.h,

        child: Align(
          alignment: AlignmentGeometry.center,
          child: Image.asset(text),
        ),
      ),
    );
  }
}

class TryAndTimeContainer extends StatelessWidget {
  const TryAndTimeContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 20.w,
      top: 20.h,
      child: BlocBuilder<GameCubit, GameState>(
        builder: (context, state) {
          if (state is GamePlaying) {
            return Container(
              // color: Colors.teal,
              width: MediaQuery.sizeOf(context).width * 0.2,
              height: 120.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(AppImages.tryPic, width: 110.w, height: 110.h),

                  Text(
                    '${state.theGame.attempts}',
                    style: getRegulerTextStyle(
                      context: context,
                      fontSize: 30.sp,
                      color: AppColors.mainColor,
                    ),
                  ),
                  Image.asset(
                    'assets/images/time2.png',
                    height: 110.h,
                    width: 110.w,
                  ),
                  Text(
                    '${state.theGame.timeLeft}',
                    style: getRegulerTextStyle(
                      context: context,
                      color: AppColors.mainColor,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Text(
              'No',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            );
          }
        },
      ),
    );
  }
}

class QustionContainer extends StatelessWidget {
  const QustionContainer({super.key, required this.color});
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 400.w,
      //  MediaQuery.sizeOf(context).height * 0.3,
      top: 20.h,
      child: Container(
        // margin: const EdgeInsets.all(220),
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        width: 1100.w,
        height: 120.h,
        child: BlocBuilder<GameCubit, GameState>(
          builder: (context, state) {
            if (state is GamePlaying) {
              return Center(
                child: Text(
                  textAlign: TextAlign.end,
                  BlocProvider.of<GameCubit>(context).currentQuestion.question,
                  style: getBoldTextStyle(
                    context: context,
                    fontSize: 35.sp,

                    color: Colors.white,
                  ),
                ),
              );
            } else {
              return const Text(
                '_',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class CharacterAndClueContainer extends StatelessWidget {
  const CharacterAndClueContainer({super.key, required this.hint});
  final String hint;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20.h,
      // left: 20.w,
      child: BlocBuilder<GameCubit, GameState>(
        builder: (context, state) {
          if (state is GamePlaying) {
            return Container(
              // color: Colors.teal,
              width: 400.w,
              height: MediaQuery.sizeOf(context).height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      BlocProvider.of<GameCubit>(context).stopTimer();

                      Navigator.pushNamed(context, Routes.avatarScreen);
                    },
                    child: BlocBuilder<PlayerCubit, PlayerModel?>(
                      builder: (context, player) {
                        if (player == null) {
                          return const SizedBox(); // أو Loader
                        }
                        return Image.asset(
                          'assets/images/avatar_${player.avatar}.png',
                          height: 150.h,
                          width: 150.w,
                        );
                      },
                    ),
                  ),
                  //clue
                  GestureDetector(
                    onTap: () {
                      BlocProvider.of<GameCubit>(context).stopTimer();

                      final myhints = BlocProvider.of<GameCubit>(
                        context,
                      ).state.theGame.hints;
                      if (myhints > 0) {
                        BlocProvider.of<GameCubit>(
                          context,
                        ).state.theGame.hints--;

                        Navigator.pushNamed(
                          context,
                          Routes.hintScreen,
                          arguments: hint,
                        );
                      } else {
                        showNoHint(context);
                      }
                    },
                    child: Image.asset(
                      AppImages.clue,
                      width: 150.w,
                      height: 150.h,
                    ),
                  ),

                  Text(
                    '${state.theGame.hints}',
                    style: getBoldTextStyle(
                      context: context,
                      color: AppColors.mainColor,
                      // fontSize: 20.sp,
                    ),
                  ),
                  //tryPic
                ],
              ),
            );
          } else {
            return const Text(
              'No',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            );
          }
        },
      ),
    );
  }

  Future<dynamic> showNoHint(BuildContext context) {
    return showDialog(
      context: context,

      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,

        elevation: 4,
        child: Container(
          // height: 500.h,
          padding: EdgeInsets.all(30.w),
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(AppImages.dialog)),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              "للاسف لا يوجد ملاحظات لديك",
              style: getRegulerTextStyle(
                context: context,
                color: Colors.black,
                fontSize: 40.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CharacterContainer extends StatelessWidget {
  CharacterContainer({super.key, this.frombottom});
  double? frombottom;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: frombottom ?? 10,
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
    );
  }
}

class DownLeftButton extends StatelessWidget {
  const DownLeftButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 10,
      bottom: 10,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      userisLoggedin ? const HomeScreen() : LoginScreen(),
                ),
              );
            },
            child: Image.asset(
              'assets/images/previous.png',
              width: 125.w,
              height: 125.h,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const InstructionsTwo()),
              );
            },
            child: Image.asset(
              'assets/images/right.png',
              width: 125.w,
              height: 125.h,
            ),
          ),
        ],
      ),
    );
  }
}

class LeftButtonTwo extends StatelessWidget {
  const LeftButtonTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 10,
      bottom: 10,
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Image.asset(
          'assets/images/previous.png',
          width: 130.w,
          height: 130.h,
        ),
      ),
    );
  }
}

class TopLogo extends StatelessWidget {
  const TopLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: MediaQuery.sizeOf(context).height * 0.5,
      // top: 10,
      child: Image.asset(
        fit: BoxFit.cover,
        'assets/images/logo.png',
        width: 1108.w,
        height: 246.h,
      ),
    );
  }
}

class DevAndSettingIcon extends StatelessWidget {
  const DevAndSettingIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10,
      left: 20,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Routes.settingScreen);
            },
            child: Image.asset(
              AppImages.setting,
              width: MediaQuery.sizeOf(context).height * 0.13,
            ),
          ),

          // GestureDetector(
          //   onTap: () {
          //     Navigator.pushNamed(context, Routes.developersScreen);
          //   },
          //   child: Image.asset(
          //     'assets/images/developers.png',
          //     width: MediaQuery.sizeOf(context).height * 0.13,
          //   ),
          // ),
        ],
      ),
    );
  }
}

// void onCorrect(BuildContext context) {
//   final cubit = context.read<GameCubit>();
//   final game = cubit.state.theGame;

//   final stars = cubit.calculateStars();
//   final previewAttempts = game.attempts;
//   final previewTime = game.timeLeft;
//   showDialog(
//     context: context,
//     barrierDismissible: true,
//     builder: (_) => AnswerResultDialog(
//       isCorrect: true,
//       stars: stars,
//       exit: () {
//         cubit.exitGame(context);
//       },
//       onNext: () {
//         Navigator.pop(context);
//         cubit.correctAnswer(context);
//       },
//       onRetry: () {
//         Navigator.pop(context);
//       },

//       hints: previewAttempts,
//       timeLeft: previewTime,
//     ),
//   );
// }

// void onWrong(BuildContext context) {
//   final cubit = context.read<GameCubit>();
//   final game = cubit.state.theGame;

//   final previewAttempts = game.attempts - 1;
//   final previewTime = 30;
//   showDialog(
//     context: context,
//     barrierDismissible: false,
//     builder: (_) => AnswerResultDialog(
//       stars: 0,
//       isCorrect: false,

//       exit: () {
//         cubit.exitGame(context);
//       },
//       onNext: () {
//         // Navigator.pop(context);
//         // cubit.correctAnswer(context);
//       },

//       onRetry: () {
//         Navigator.pop(context);
//         cubit.wrongAnswer(context);
//       },
//       hints: previewAttempts,
//       timeLeft: previewTime,
//     ),
//   );
// }

class AnswerResultDialog extends StatelessWidget {
  final bool isCorrect;
  final int stars;
  final int hints;
  final int timeLeft;
  final VoidCallback onNext;
  final VoidCallback onRetry;
  final VoidCallback exit;

  const AnswerResultDialog({
    super.key,
    required this.isCorrect,
    this.stars = 0,
    required this.onNext,
    required this.onRetry,
    required this.exit,
    required this.hints,
    required this.timeLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(30.w),
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(AppImages.dialog)),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              isCorrect ? 'تمت انجاز المهمة بنجاح' : '❌إجابة خاطئة ',
              style: getRegulerTextStyle(
                context: context,
                fontSize: 80.sp,
                color: AppColors.accentColor,
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$timeLeft ث ",
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$hints ",
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isCorrect) ...[StarRow(stars: stars)],

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

            if (isCorrect)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: exit,
                    child: Image.asset(
                      AppImages.exit,
                      width: 200.w,
                      height: 200.h,
                    ),
                  ),
                  SizedBox(width: 25.w),
                  GestureDetector(
                    onTap: onRetry,
                    child: Image.asset(
                      AppImages.retry,
                      width: 200.w,
                      height: 200.h,
                    ),
                  ),
                  SizedBox(width: 25.w),
                  GestureDetector(
                    onTap: onNext,
                    child: Image.asset(
                      AppImages.next1,
                      width: 200.w,
                      height: 200.h,
                    ),
                  ),
                ],
              )
            // ElevatedButton(onPressed: onNext, child: const Text('التالي'))
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: exit,
                    child: Image.asset(
                      AppImages.exit,
                      width: 200.w,
                      height: 200.h,
                    ),
                  ),
                  SizedBox(width: 25.w),
                  GestureDetector(
                    onTap: onRetry,
                    child: Image.asset(
                      AppImages.retry,
                      width: 200.w,
                      height: 200.h,
                    ),
                  ),
                  SizedBox(width: 25.w),
                  GestureDetector(
                    onTap: () {},
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
    );
  }
}

class StarRow extends StatefulWidget {
  final int stars;
  const StarRow({super.key, required this.stars});

  @override
  State<StarRow> createState() => _StarRowState();
}

class _StarRowState extends State<StarRow>
    with TickerProviderStateMixin, RestartableAnimations {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return ScaleTransition(
          scale: Tween(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: _controller,
              curve: Interval(index * 0.1, 1, curve: Curves.elasticOut),
            ),
          ),
          child: Icon(
            Icons.star,
            size: 100.sp,
            color: index < widget.stars ? Colors.amber : Colors.grey.shade300,
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
