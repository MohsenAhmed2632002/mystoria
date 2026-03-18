import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myhabits/Core/Images&colors.dart';
import 'package:myhabits/Core/constants.dart';
import 'package:myhabits/Models/QuestionModel.dart';

class LibraryPuzzle extends StatefulWidget {
  final QuestionModel question;

  const LibraryPuzzle({super.key, required this.question});

  @override
  State<LibraryPuzzle> createState() => _LibraryPuzzleState();
}

class _LibraryPuzzleState extends State<LibraryPuzzle> {
  Map<int, List<String>> userLibrary = {0: [], 1: [], 2: []};

  /// الترتيب الصحيح
  final Map<int, List<String>> correctLibrary = {
    0: [AppImages.papyrus1],
    2: [AppImages.papyrus2],
    1: [AppImages.papyrus3],
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
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                bool isUsed = userLibrary.values.any(
                  (list) => list.contains(item),
                );

                return isUsed ? const SizedBox.shrink() : _buildDraggable(item);
              }).toList(),
            ),

            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildDraggable(String item) {
    return Draggable<String>(
      data: item,
      feedback: Image.asset(item, width: 500.w, height: 300.h),
      childWhenDragging: Opacity(
        opacity: 0.3,
        child: Image.asset(item, width: 500.w, height: 300.h),
      ),
      child: Image.asset(item, width: 500.w, height: 300.h),
    );
  }

  Widget _buildLibrary(int index, String imagePath) {
    return DragTarget<String>(
      onAccept: (data) {
        setState(() {
          userLibrary[index]!.add(data);
        });

        _checkResult();
      },
      builder: (context, candidate, rejected) {
        return Container(
          width: 300.w,
          height: 500.h,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(imagePath)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: userLibrary[index]!
                .map((e) => Image.asset(e, width: 500))
                .toList(),
          ),
        );
      },
    );
  }

  void _checkResult() {
    int totalItems = userLibrary.values.fold(
      0,
      (sum, list) => sum + list.length,
    );

    if (totalItems < widget.question.options.length) return;

    bool isCorrect = true;

    correctLibrary.forEach((key, value) {
      if (userLibrary[key]!.join() != value.join()) {
        isCorrect = false;
      }
    });

    if (isCorrect) {
      onCorrect(context);
    } else {
      onWrong(context);
      userLibrary = {0: [], 1: [], 2: []};
      setState(() {});
    }
  }
}
