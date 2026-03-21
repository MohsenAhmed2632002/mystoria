import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myhabits/Core/Font.dart';
import 'package:myhabits/Core/Images&colors.dart';
import 'package:myhabits/Core/constants.dart';
import 'package:myhabits/Models/TripleModel.Dart';

class NetworkQ extends StatefulWidget {
  const NetworkQ({super.key});

  @override
  State<NetworkQ> createState() => _NetworkQState();
}

class _NetworkQState extends State<NetworkQ> {
  /// الإجابة الصحيحة
  final List<TripleItem> correctTriples = [
    TripleItem(
      king: AppImages.zosar,
      family: 'الاسرة الثالثة',
      achievement: AppImages.stepPyramid,
    ),
    TripleItem(
      king: AppImages.khofo,
      family: 'ثاني ملوك الاسرة الرابعة',
      achievement: AppImages.bigPyramid,
    ),
    TripleItem(
      king: AppImages.khafraa,
      family: 'ثالث ملوك الاسرة الرابعة',
      achievement: AppImages.aboAlhawl,
    ),
  ];

  /// العناصر القابلة للسحب
  late List<TripleItem> draggableItems;

  /// اختيارات المستخدم
  final Map<int, TripleItem> userTriples = <int, TripleItem>{};

  @override
  void initState() {
    super.initState();

    draggableItems = [...correctTriples]..shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return GameScreen(
      color: AppColors.blueColor,
      hint: 'أربط بين الملك و عصره و اثره الشهير',

      background: AppImages.quiz1,
      mediaQueryRight: 0,
      mediaQueryTop: MediaQuery.sizeOf(context).height * 0.05,
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,

        // color: Colors.red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            /// 🔹 Draggables (الملوك)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: draggableItems
                  .map<Widget>((item) => _buildDraggableTwo(item))
                  .toList(),
            ),
            //الصور
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: draggableItems
                  .map<Widget>((item) => _buildDraggable(item))
                  .toList(),
            ),

            /// 🔹 Targets (الأبواب)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                correctTriples.length,
                (index) => _buildDoor(index, correctTriples[index].family),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🟦 Draggable
  Widget _buildDraggable(TripleItem item) {
    return Draggable<TripleItem>(
      data: item,
      feedback: _card(item.achievement, dragging: true),
      childWhenDragging: _card(item.achievement, faded: true),
      child: _card(item.achievement),
    );
  }

  // 🟦 Draggable
  Widget _buildDraggableTwo(TripleItem item) {
    return Draggable<TripleItem>(
      data: item,
      feedback: _card(item.king, dragging: true),
      childWhenDragging: _card(item.king, faded: true),
      child: _card(item.king),
    );
  }

  // 🟨 Card UI
  Widget _card(String image, {bool dragging = false, bool faded = false}) {
    return Opacity(
      opacity: faded ? 0.3 : 1,
      child: Image.asset(image, width: 250.w, height: 250.h),
    );
  }

  // 🚪 Door (Target)
  Widget _buildDoor(int index, String familyText) {
    return DragTarget<TripleItem>(
      onAccept: (item) {
        setState(() {
          userTriples[index] = item;
        });
        _checkResult();
      },
      builder: (context, candidateData, rejectedData) {
        final placed = userTriples[index];

        return Container(
          margin: const EdgeInsets.all(8),
          width: 500.w,
          height: 150.h,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.buttongame),
              fit: BoxFit.fill,
            ),
          ),
          child: Center(
            child: placed == null
                ? Text(
                    familyText,
                    style: getRegulerTextStyle(
                      context: context,
                      fontSize: 18.sp,
                    ),
                  )
                : Image.asset(placed.achievement, width: 120.w),
          ),
        );
      },
    );
  }

  // ✅ التحقق من الحل
  void _checkResult() {
    if (userTriples.length < correctTriples.length) return;

    bool correct = true;

    for (int i = 0; i < correctTriples.length; i++) {
      final user = userTriples[i];
      final correctItem = correctTriples[i];

      if (user == null ||
          user.king != correctItem.king ||
          user.family != correctItem.family ||
          user.achievement != correctItem.achievement) {
        correct = false;
        break;
      }
    }

    if (correct) {
      onCorrect(context);
      // onWrong(  context);
      // context.read<GameCubit>().correctAnswer(context);
    } else {
      // onCorrect(context);
      onWrong(context);
      // context.read<GameCubit>().wrongAnswer(context);
      userTriples.clear();
      setState(() {});
    }
  }
}
