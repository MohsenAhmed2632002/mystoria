import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myhabits/Core/Font.dart';
import 'package:myhabits/Core/Images&colors.dart';
import 'package:myhabits/Core/constants.dart';
import 'package:myhabits/Core/soundManger.dart';
import 'package:myhabits/Models/QuestionModel.dart';
import 'package:myhabits/cubit/Gamecubit/game_cubit.dart';
import 'package:myhabits/cubit/Gamecubit/game_state.dart';

class LevelTwoPuzzeleSix extends StatefulWidget {
  LevelTwoPuzzeleSix({super.key, required this.question});
  final QuestionModel question;
  @override
  State<LevelTwoPuzzeleSix> createState() => _LevelTwoPuzzeleSixViewState();
}

class _LevelTwoPuzzeleSixViewState extends State<LevelTwoPuzzeleSix> {
  final Map<String, String> userMatches = {};
  bool locked = false;

  final List<String> myAnswers = [
    AppImages.fund1,
    AppImages.fund2,
    AppImages.fund3,
    AppImages.fund4,
  ];
  @override
  void initState() {
    SoundManager.instance.stopBgm().then((_) {
      BlocProvider.of<GameCubit>(context).initState(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("userMatches$userMatches and length:${userMatches.length}");

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // 🎨 الخلفية
          SizedBox.expand(
            child: Image.asset(AppImages.quiz1, fit: BoxFit.fill),
          ),
          // 🎨 الجسم
          Positioned(
            right: MediaQuery.sizeOf(context).width * 0,
            top: MediaQuery.sizeOf(context).height * 0.05,
            child: Container(
              height: MediaQuery.sizeOf(context).height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    // color: AppColors.secondColor,
                    height: MediaQuery.sizeOf(context).height / 2,
                    width: MediaQuery.sizeOf(context).width,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          _buildDoor(index, myAnswers[index]),
                      padding: EdgeInsets.only(left: 300.w),
                      itemCount: myAnswers.length,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 🎨 الأيقونات العلوية
          CharacterAndClueContainer(hint: "تذكر : كل حضاره ليها بدايه واضحه"),

          CharacterContainer(), // 🎨 الأيقونات العلوية
          Positioned(
            right: MediaQuery.sizeOf(context).height * 0.3,
            top: 10,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(AppImages.forbid),
                ),
              ),
              width: 1100.w,
              height: 500.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ...widget.question.options.map(
                        (e) => _buildDraggableCard(e),
                        // Image.asset(e, width: 300.w)
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ), // 🎨 الأيقونات العلوية
          TryAndTimeContainer(),

          // ),
        ],
      ),
    );
  }

  // 🟦 البطاقة
  Widget _buildDraggableCard(String era) {
    return Draggable<String>(
      data: era,
      childWhenDragging: _card(era, faded: true),
      // السحب
      feedback: _card(era, dragging: true),
      child: _card(era),
    );
  }

  Widget _card(String text, {bool dragging = false, bool faded = false}) {
    return Opacity(
      opacity: faded ? 0.3 : 1,
      child: GameButtonThree(
        text: text,
        onPressed: () {},
        fromWidth: 300,
        fromHeight: 150,
        fontSize: 25,
      ),
    );
  }

  // 🚪 الباب
  Widget _buildDoor(int index, String image) {
    return DragTarget<String>(
      onWillAccept: (_) => !locked,
      onAccept: (data) {
        SoundManager.instance.closeTheBox();
        setState(() {
          userMatches[data] = image;
        });
        _checkResult();
      },
      builder: (context, candidateData, rejectedData) {
        final isFilled = userMatches.containsValue(image);

        return Padding(
          padding: EdgeInsets.only(right: 100.w),
          child: Image.asset(
            isFilled ? image + "closed" : image,

            width: 270.w,
            height: 300.h,
            // color: isFilled ? Colors.amberAccent : null,
            // opacity: AlwaysStoppedAnimation(isFilled ? 0.5 : 1),
          ),
        );
      },
    );
  }

  // ✅ التحقق من الحل
  void _checkResult() async {
    print("userMatches$userMatches and length:${userMatches.length}");

    if (userMatches.length < widget.question.correctAnswer.length) return;

    bool allCorrect = true;

    userMatches.forEach((stone, box) {
      if (widget.question.correctAnswer[stone] != box) {
        allCorrect = false;
      }
    });

    if (allCorrect) {
      locked = true;
      SoundManager.instance.correct();
      onCorrect(context);
    } else {
      locked = true;
      SoundManager.instance.closeTheBox();
      await Future.delayed(const Duration(seconds: 2));

      userMatches.clear();
      locked = false;

      onWrong(context);
    }
  }
}
