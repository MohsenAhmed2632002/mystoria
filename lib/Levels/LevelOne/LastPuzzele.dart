import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myhabits/Core/Font.dart';
import 'package:myhabits/Core/Images&colors.dart';
import 'package:myhabits/Core/constants.dart';
import 'package:myhabits/Models/QuestionModel.dart';

class TheDoorQuestion extends StatefulWidget {
  final QuestionModel question;
  const TheDoorQuestion({super.key, required this.question});

  @override
  State<TheDoorQuestion> createState() => _TheDoorQuestionState();
}

class _TheDoorQuestionState extends State<TheDoorQuestion> {
  final _controllers = List.generate(4, (_) => TextEditingController());

  final List<String> questions = [
    'ترتيب الدولة القديمة بين العصور',
    'عدد أهرامات سنفرو',
    'الأسرة التي انتهت معها عصر الدولة القديمة',
    'عدد عصور مصر القديمة الأساسية',
  ];

  final String correctCode = '1263';
  bool answered = false;
  
  @override
  Widget build(BuildContext context) {
    return GameScreen(
      color: widget.question.color,
      background: widget.question.background,
      mediaQueryRight: 0,
      mediaQueryTop: MediaQuery.sizeOf(context).height * 0.1,
      hint: widget.question.hint,
      child: Container(
        // color: Colors.cyan,
        height: MediaQuery.sizeOf(context).height * 1,
        width: MediaQuery.sizeOf(context).width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            answered
                ? Image.asset(
                    AppImages.bigDoorOpen,
                    width: 950.w,
                    height: 950.h,
                  )
                : Image.asset(
                    AppImages.bigDoorClose,
                    width: 950.w,
                    height: 950.h,
                  ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  // color: Colors.white,
                  width: 800.w,
                  height: 700.h,
                  child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 20.h),
                    itemCount: widget.question.options.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: AppColors.backgroundColor,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        width: 1000.w,
                        height: 150.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _numberField(_controllers[index]),
                            Text(
                              widget.question.options[index],
                              style: getArabLightTextStyle(
                                context: context,
                                fontSize: 30.sp,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                GameButton(
                  text: "فتح الباب",
                  onPressed: _checkAnswer,
                  fromWidth: 500,
                  fromHeight: 150,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _numberField(TextEditingController controller) {
    return SizedBox(
      height: 70,
      width: 100.w,
      child: TextField(
        onChanged: (value) {
          if (value.length == 1) {
            // ينقل التركيز للعنصر التالي تلقائياً
            FocusScope.of(context).nextFocus();
          }
        },
        controller: controller,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        decoration: const InputDecoration(
          counterText: '',
          border: OutlineInputBorder(),
        ),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      ),
    );
  }

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  //TODO:
  void _checkAnswer() async {
    final enteredCode = _controllers.map((c) => c.text).join();

    if (enteredCode == correctCode) {
      setState(() {
        answered = true;
      });
      onCorrect(context);
    } else {
      // ❌ إجابة خاطئة
      for (var c in _controllers) {
        c.clear();
      }

      onWrong(context);
    }
  }
}
