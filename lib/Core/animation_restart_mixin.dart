import 'package:flutter/material.dart';

mixin RestartableAnimations<T extends StatefulWidget> on State<T> {
  final List<AnimationController> _controllers = [];

  void registerController(AnimationController controller) {
    _controllers.add(controller);
  }

  void restartAllAnimations() {
    for (var controller in _controllers) {
      if (controller.isAnimating) {
        controller.stop();
      }
      controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}