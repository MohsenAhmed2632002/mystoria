import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mystoria/Core/Font.dart';
import 'package:mystoria/Core/Images&colors.dart';
import 'package:mystoria/Core/animation_restart_mixin.dart';
import 'package:mystoria/Core/constants.dart';
import 'package:mystoria/Core/soundManger.dart';
import 'package:mystoria/Models/PlayerModel.dart';
import 'package:mystoria/Models/QuestionModel.dart';
import 'package:mystoria/Screens/feedackScreen.dart';
import 'package:mystoria/cubit/Gamecubit/game_cubit.dart';
import 'package:mystoria/cubit/Playercubit/Playercubit.dart';

class LevelThreePuzzeleOne extends StatefulWidget {
  final QuestionModel question;

  const LevelThreePuzzeleOne({super.key, required this.question});
  @override
  State<LevelThreePuzzeleOne> createState() => _LevelThreePuzzeleOneViewState();
}

class _LevelThreePuzzeleOneViewState extends State<LevelThreePuzzeleOne> {
  // with TickerProviderStateMixin, RestartableAnimations {
  bool answered = false;
  // late AnimationController stonesController;
  // late Animation<double> stonesDrop;

  bool showStones = false;
  final List<String> userOrder = [];

  // @override
  // void initState() {
  //   // SoundManager.instance.stopBgm().then((_) {
  //   // BlocProvider.of<GameCubit>(context).initState(context);
  //   // });
  //   stonesController = AnimationController(
  //     vsync: this,
  //     duration: const Duration(milliseconds: 800),
  //   );

  //   registerController(stonesController);

  //   stonesDrop = Tween<double>(
  //     begin: -1,
  //     end: 0,
  //   ).animate(CurvedAnimation(parent: stonesController, curve: Curves.easeIn));
  //   super.initState();
  // }
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GameCubit>(context).initState(context);
  }

  @override
  Widget build(BuildContext context) {
    return GameScreen(
      hint: widget.question.hint,
      color: widget.question.color,
      background: widget.question.background,
      mediaQueryRight: 0,
      mediaQueryTop: MediaQuery.sizeOf(context).height * 0.1,
      child: Container(
        // color: Colors.red,
        height: MediaQuery.sizeOf(context).height * 0.9,
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildChoicesContainer(widget.question.options[0]),
                _buildChoicesContainer(widget.question.options[1]),
                _buildChoicesContainer(widget.question.options[2]),
              ],
            ),

            // DragTarget<String>(
            //   onAccept: (data) {
            //     setState(() {
            //       userOrder = data;
            //     });
            //     _checkResult();
            //   },
            //   builder: (context, candidateData, rejectedData) {
            //     return Container(
            //       width: 300.w,
            //       height: 250.h,
            //       child: Image.asset(
            //         AppImages.breakInMirror,
            //         fit: BoxFit.fill,
            //       ),
            //     );
            //   },
            // ),

            // Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [],
            // ),
          ],
        ),
      ),
    );
  }

  // 🚪 الباب
  Widget _buildChoicesContainer(String image) {
    return GestureDetector(
      onTap: () => _checkResult(image),

      child: Image.asset(image, width: 400.w, height: 600.h),
    );
  }

  // ✅ التحقق من الحل
  void _checkResult(String selectedImage) async {
    if (selectedImage == widget.question.correctAnswer) {
      SoundManager.instance.correct();
      userOrder.clear();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => FeedackScreen(
            isCorrect: true,
            stars: BlocProvider.of<GameCubit>(context).calculateStars(),
            attempts: BlocProvider.of<GameCubit>(
              context,
            ).state.theGame.attempts,
            timeLeft: BlocProvider.of<GameCubit>(
              context,
            ).state.theGame.timeLeft,
          ),
        ),
      );
      // SoundManager.instance.wind();
    } else {
      // restartAllAnimations();
      SoundManager.instance.wrong();
      userOrder.clear();
      // userOrder.clear();
      setState(() {});
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => FeedackScreen(
            isCorrect: false,
            stars: 0,
            attempts:
                BlocProvider.of<GameCubit>(context).state.theGame.attempts - 1,
            timeLeft: BlocProvider.of<GameCubit>(
              context,
            ).state.theGame.timeLeft,
          ),
        ),
      );
    }
  }
}
