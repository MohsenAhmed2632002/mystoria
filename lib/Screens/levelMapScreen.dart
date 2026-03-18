import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myhabits/Core/Images&colors.dart';
import 'package:myhabits/Models/LevelsModel.dart';
import 'package:myhabits/cubit/Gamecubit/game_cubit.dart';

class LevelMapScreen extends StatelessWidget {
  const LevelMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// الخلفية
          SizedBox.expand(
            child: Image.asset(AppImages.mapPage, fit: BoxFit.cover),
          ),
          ...levelStages.map((stage) => StageButton(stage: stage)),
        ],
      ),
    );
  }
}

class StageButton extends StatelessWidget {
  final StageModel stage;

  const StageButton({super.key, required this.stage});

  @override
  Widget build(BuildContext context) {
    final stars = context.watch<GameCubit>().state.theGame.stars;
    final isUnlocked = stars >= stage.requiredStars;

    return Positioned(
      left: stage.position.dx.w,
      top: stage.position.dy.h,
      child: GestureDetector(
        onTap: isUnlocked
            ? () {
                context.read<GameCubit>().startLevel(stage.id - 1, context);

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => stage.levelScreen),
                );
              }
            : () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'تحتاج ${stage.requiredStars} نجمة لفتح هذه المرحلة ⭐',
                    ),
                  ),
                );
              },
        child: Opacity(
          opacity: isUnlocked ? 1 : 0.3,
          child: Row(
            children: [
              Text(
                '${stage.requiredStars} ⭐',
                style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Image.asset(
                stage.image,
                width: stage.imageWidth,
                height: stage.imageHeight,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
