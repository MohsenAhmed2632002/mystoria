import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myhabits/Core/Images&colors.dart';
import 'package:myhabits/Core/animation_restart_mixin.dart';
import 'package:myhabits/Core/constants.dart';
import 'package:myhabits/Core/soundManger.dart';
import 'package:myhabits/Models/QuestionModel.dart';

class LevelTwoBordersPuzzle extends StatefulWidget {
  final QuestionModel question;

  const LevelTwoBordersPuzzle({super.key, required this.question});

  @override
  State<LevelTwoBordersPuzzle> createState() => _LevelTwoBordersPuzzleState();
}

class _LevelTwoBordersPuzzleState extends State<LevelTwoBordersPuzzle>
    with TickerProviderStateMixin, RestartableAnimations {
  Set<String> completedDoors = {};
  Set<String> droppedDoors = {};
  late AnimationController symbolsController;
  late Animation<double> symbolsDrop;
  bool gameFinished = false;

  String? activeDoor;

  late AnimationController doorController;
  late Animation<double> doorDrop;

  Map<String, List<String>> placedSymbols = {};

  final List<String> doors = [
    AppImages.door3Q10,
    AppImages.door2Q10,
    AppImages.door1Q10,
  ];

  @override
  void initState() {
    super.initState();
    symbolsController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    registerController(symbolsController);
    symbolsDrop = Tween<double>(begin: -1, end: 0).animate(
      CurvedAnimation(parent: symbolsController, curve: Curves.easeOut),
    );
    symbolsController.forward(from: 0);

    doorController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    registerController(doorController);
    doorDrop = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: doorController, curve: Curves.easeIn));
  }

  // @override
  // void dispose() {
  //   doorController.dispose();
  //   symbolsController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return GameScreen(
      characterFromBottom: 125.h,
      hint: widget.question.hint,
      color: widget.question.color,
      background: widget.question.background,
      mediaQueryRight: 0,
      mediaQueryTop: MediaQuery.sizeOf(context).height * 0.2,
      child: Column(
        children: [
          /// الأبواب
          Container(
            // color: Colors.red,
            height: 700.h,
            width: MediaQuery.sizeOf(context).width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: doors.map((door) => _buildDoor(door)).toList(),
            ),
          ),

          // const SizedBox(height: 20),

          /// الرموز
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 20.w,
            children: widget.question.options
                .map((symbol) => _buildDraggable(symbol))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDraggable(String image) {
    return AnimatedBuilder(
      animation: symbolsController,
      builder: (context, child) {
        final screenHeight = MediaQuery.of(context).size.height;

        double position = screenHeight * symbolsDrop.value;
        print(position);
        return Transform.translate(
          offset: Offset(0, position),
          child: Draggable<String>(
            data: image,
            feedback: Image.asset(image, width: 150.w),
            childWhenDragging: Opacity(
              opacity: 0.3,
              child: Image.asset(image, width: 150.w),
            ),
            child: Image.asset(image, width: 150.w, height: 150.h),
          ),
        );
      },
    );
  }

  Widget _buildDoor(String doorImage) {
    if (droppedDoors.contains(doorImage)) {
      return const SizedBox();
    }

    return AnimatedBuilder(
      animation: doorController,
      builder: (context, child) {
        final dropOffset = activeDoor == doorImage
            ? MediaQuery.of(context).size.height * doorDrop.value
            : 0.0;

        return Transform.translate(
          offset: Offset(0, dropOffset),
          child: DragTarget<String>(
            onAccept: (symbol) => _handleDrop(doorImage, symbol),
            builder: (context, candidate, rejected) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(doorImage, width: 450.w, height: 720.h),
                  Positioned(
                    bottom: 250.h,
                    child: Row(
                      children: placedSymbols[doorImage] != null
                          ? placedSymbols[doorImage]!
                                .map(
                                  (e) => Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.w,
                                    ),
                                    child: Image.asset(e, width: 100.w),
                                  ),
                                )
                                .toList()
                          : [],
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  void _handleDrop(String door, String symbol) {
    if (gameFinished) return;
    if (droppedDoors.contains(door)) return;

    placedSymbols.putIfAbsent(door, () => []);

    if (placedSymbols[door]!.contains(symbol)) return;
    if (placedSymbols[door]!.length >= 2) return;

    placedSymbols[door]!.add(symbol);
    setState(() {});

    if (placedSymbols[door]!.length == 2) {
      completedDoors.add(door);
    }

    if (completedDoors.length == doors.length) {
      _evaluateAllDoors();
    }
  }

  Future<void> _evaluateAllDoors() async {
    final correctMap =
        widget.question.correctAnswer as Map<String, List<String>>;

    bool allCorrect = true;

    for (var door in doors) {
      final correctList = correctMap[door] ?? [];
      final placed = placedSymbols[door] ?? [];

      if (!_isCorrectSet(placed, correctList)) {
        allCorrect = false;
        await _dropDoor(door);
      }
    }

    if (allCorrect) {
      gameFinished = true;
      _success();
    } else {
      _resetGameState();
      restartAllAnimations();
      onWrong(context);
    }
  }

  void _resetGameState() {
    completedDoors.clear();
    droppedDoors.clear();
    placedSymbols.clear();
    activeDoor = null;
    gameFinished = false;

    setState(() {});
  }

  Future<void> _dropDoor(String door) async {
    activeDoor = door;
    setState(() {});

    SoundManager.instance.wrong();

    await doorController.forward(from: 0);
    doorController.reset();

    droppedDoors.add(door);
    activeDoor = null;

    setState(() {});
  }

  bool _isCorrectSet(List<String> placed, List<String> correct) {
    if (placed.length != correct.length) return false;
    for (var item in placed) {
      if (!correct.contains(item)) return false;
    }
    return true;
  }

  void _success() async {
    SoundManager.instance.correct();
    await Future.delayed(const Duration(milliseconds: 600));
    onCorrect(context);
  }
}
