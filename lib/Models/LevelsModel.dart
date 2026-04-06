import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myhabits/Core/Images&colors.dart';
import 'package:myhabits/Levels/LevelOne/LevelOne.dart';
import 'package:myhabits/Levels/LevelThree/LevelThree.dart';
import 'package:myhabits/Levels/LevelTwo/LevelTwo.dart';

final List<StageModel> levelStages = [
  StageModel(
    id: 1,
    requiredStars: 0,
    image: AppImages.mapad1,
    //        space from left, space from top
    position: const Offset(50, 50),
    imageWidth: 500.w,
    imageHeight: 500.h,
    levelScreen: const LevelOne(),
  ),
  StageModel(
    id: 2,
    requiredStars: 30,
    image: AppImages.mapad2,
    position: const Offset(1100, 50),
    imageWidth: 500.w,
    imageHeight: 500.h,
    levelScreen: const LevelTwo(),
  ),
  StageModel(
    levelScreen: const LevelThree(),
    id: 3,
    requiredStars: 60,
    image: AppImages.mapad3,
    position: const Offset(450, 500),
    imageWidth: 500.w,
    imageHeight: 500.h,
  ),
];

class StageModel {
  final int id;
  final int requiredStars;
  final String image;
  final Offset position; // مكان الزر على الخريطة
  final double imageWidth;
  final double imageHeight;
  final Widget levelScreen;

  StageModel({
    required this.id,
    required this.requiredStars,
    required this.image,
    required this.position,
    required this.imageWidth,
    required this.imageHeight,
    required this.levelScreen,
  });
}
