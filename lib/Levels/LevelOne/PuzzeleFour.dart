import 'package:flutter/material.dart';
import 'package:mystoria/Core/Font.dart';
import 'package:mystoria/Core/Images&colors.dart';

class ChoiceWidget extends StatelessWidget {
  const ChoiceWidget({super.key, required this.widget});

  final widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(AppImages.buttongame)),
      ),
      child: Center(
        child: Text(
          widget.question.options[0],
          style: getRegulerTextStyle(
            context: context,
            color: AppColors.mainColor,
            // fontSize: 30,
          ),
        ),
      ),
    );
  }
}
