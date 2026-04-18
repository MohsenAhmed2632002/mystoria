import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myhabits/Core/Images&colors.dart';
import 'package:myhabits/Core/constants.dart';
import 'package:myhabits/Core/soundManger.dart';
import 'package:myhabits/Models/QuestionModel.dart';
import 'package:myhabits/Screens/feedackScreen.dart';
import 'package:myhabits/cubit/Gamecubit/game_cubit.dart';

class LibraryPuzzle extends StatefulWidget {
  final QuestionModel question;

  const LibraryPuzzle({super.key, required this.question});

  @override
  State<LibraryPuzzle> createState() => _LibraryPuzzleState();
}

class _LibraryPuzzleState extends State<LibraryPuzzle> {
  @override
  void initState() {
    super.initState();
    userOrder = {0: ?null, 1: ?null, 2: ?null};
  }

  final List<String> items = [
    AppImages.flower,
    AppImages.knife,
    AppImages.bigPyramid2,
  ];

  Map<int, String> userOrder = {};

  /// الترتيب الصحيح
  final Map<int, String> correctOrder = {
    0: AppImages.flower,
    2: AppImages.knife,
    1: AppImages.bigPyramid2,
  };

  @override
  Widget build(BuildContext context) {
    return GameScreen(
      color: widget.question.color,
      hint: widget.question.hint,
      background: widget.question.background,
      mediaQueryRight: 0,
      mediaQueryTop: MediaQuery.sizeOf(context).height * 0.1,
      child: Container(
        // color: AppColors.mainColor,
        height: MediaQuery.sizeOf(context).height * 0.9,
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            /// المكتبات
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildLibrary(0, AppImages.flower),
                _buildLibrary(1, AppImages.knife),
                _buildLibrary(2, AppImages.bigPyramid2),
              ],
            ),

            /// العناصر القابلة للسحب
            Wrap(
              spacing: 20.w,
              children: widget.question.options.map((item) {
                bool isUsed = userOrder.values.any(
                  (list) => list.contains(item),
                );

                return isUsed ? const SizedBox.shrink() : _buildDraggable(item);
              }).toList(),
            ),
            Container(
              // color: AppColors.mainColor,
              width: MediaQuery.sizeOf(context).width,

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _placeOfAnswers(0),
                  _placeOfAnswers(1),
                  _placeOfAnswers(2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLibrary(int index, String imagePath) {
    return Draggable<String>(
      data: imagePath,
      feedback: Image.asset(imagePath, width: 350.w, height: 350.h),
      // child: Container(
      // width: 450.w,
      // height: 350.h,
      // decoration: BoxDecoration(
      // color: Colors.black45,
      // image: DecorationImage(image: AssetImage(imagePath)),
      // ),
      child: Image.asset(items[index], width: 350.w, height: 350.h),
      // ),
    );
  }

  Widget _buildDraggable(String item) {
    return Container(
      // color: Colors.white38,
      width: 500.w,
      height: 300.h,
      child: Image.asset(item, width: 500.w, height: 300.h),
    );
  }

  Widget _placeOfAnswers(int index) {
    return DragTarget<String>(
      onAccept: (data) {
        setState(() {
          userOrder[index] = data;
        });
        _checkResult();
      },
      builder: (context, candidateData, rejectedData) {
        return Image.asset(
          userOrder[index] != null || userOrder[index] == ''
              ? userOrder[index]!
              // آخر عنصر تم إضافته
              : AppImages.apartmentTiles, // الصورة الافتراضيةwidth: 300.w,
          height: 300.h,
          width: 250.w,
        );
      },
    );
  }

  // التحقق من الإجابة
  void _checkResult() {
    // حساب عدد العناصر المستخدمة
    int totalItems = userOrder.values.where((value) => value.isNotEmpty).length;

    if (totalItems < widget.question.options.length) return;

    bool isCorrect = true;
    correctOrder.forEach((key, value) {
      if (userOrder[key] != value) {
        isCorrect = false;
      }
    });

    if (isCorrect) {
      SoundManager.instance.correct();

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
    } else {
      SoundManager.instance.wrong();

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
