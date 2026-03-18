import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myhabits/Core/Images&colors.dart';
import 'package:myhabits/Core/constants.dart';
import 'package:myhabits/Core/soundManger.dart';
import 'package:myhabits/Models/QuestionModel.dart';
import 'package:myhabits/cubit/Gamecubit/game_cubit.dart';

class LevelTwoPuzzeleOne extends StatefulWidget {
  final QuestionModel question;

  const LevelTwoPuzzeleOne({super.key, required this.question});
  @override
  State<LevelTwoPuzzeleOne> createState() => _LevelTwoPuzzeleOneViewState();
}
 
class _LevelTwoPuzzeleOneViewState extends State<LevelTwoPuzzeleOne> {
  final List<String> userOrder = [];
  bool _rghitAnswer = true;

  bool _rghitAnswer2 = false;
  @override
  void initState() {
    SoundManager.instance.stopBgm().then((_) {
      BlocProvider.of<GameCubit>(context).initState(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GameScreen(
      color: widget.question.color,
      hint: widget.question.hint,

      background: widget.question.background,
      mediaQueryRight: MediaQuery.sizeOf(context).width * 0,
      mediaQueryTop: MediaQuery.sizeOf(context).height * 0.05,
      child: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DragTarget<String>(
              onAccept: (data) {
                setState(() {
                  userOrder.add(data);
                });
                print(_rghitAnswer);
                _checkResult();
              },
              builder: (context, candidateData, rejectedData) {
                return Container(
              
                  width: 1000.w,

                  // height: 1000.h,
                  child: 
                  
                  
                  Stack(
                    children: [
                      SizedBox(
                        child: Image.asset(
                          AppImages.image1234,
                          fit: BoxFit.fill,
                          color: _rghitAnswer2 ? Colors.yellow : null,
                        ),
                      ),

                      Center(
                        child: Container(
                          // color: AppColors.mainColor,
                          width: 650.w,
                          height: 750.h,
                          child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10.h,
                                  crossAxisSpacing: 10.w,
                                ),
                            itemBuilder: (context, index) =>
                                userOrder[index] != null
                                ? Image.asset(
                                    userOrder[index],
                                    width: 400.w,
                                    height: 200.h,
                                  )
                                : const SizedBox(),

                            itemCount: userOrder.length,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            Container(
              width: 700.w,
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.h,
                  crossAxisSpacing: 10.w,
                ),
                itemBuilder: (context, index) =>
                    _buildChoicesContainer(widget.question.options[index]),
                itemCount: widget.question.options.length,
              ),
            ),
            // Spacer(flex: 3),
            _rghitAnswer
                ? SizedBox.shrink()
                : Image.asset(AppImages.wall, width: 150.w),
          ],
        ),
      ),
    );
  }

  // 🚪 الباب
  Widget _buildChoicesContainer(String image) {
    return Draggable<String>(
      data: image,
      childWhenDragging: _card(image, faded: true),
      // السحب
      feedback: _card(image, dragging: true),
      child: _card(image),
    );
  }

  Widget _card(String text, {bool dragging = false, bool faded = false}) {
    return Opacity(
      opacity: faded ? 0.5 : 1,
      child: Column(children: [Image.asset(text, width: 300.w)]),
    );
  }

  // ✅ التحقق من الحل
  void _checkResult() async {
    if (userOrder.length < 4) return;

    bool isCorrect = true;

    widget.question.correctAnswer.forEach((key, value) {
      if (userOrder[key] != value) {
        isCorrect = false;
      }
    });

    if (isCorrect) {
      setState(() {
        _rghitAnswer2 = true;
      });
      onCorrect(context);
    } else {
      setState(() {
        _rghitAnswer = false;
      });

      // restartAllAnimations();

      onWrong(context);
      userOrder.clear();
      setState(() {});
    }
  }
}
