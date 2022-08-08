import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomeWidgetAnimation extends StatelessWidget {
  final Widget child;
  const HomeWidgetAnimation({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Animate(
        effects: const [
          ShimmerEffect(
              delay: Duration(milliseconds: 1),
              color: Colors.red,
              size: 1,
              duration: Duration(seconds: 1))
        ],
        onInit: (controller) {
          controller.repeat();
        },
        child: child);
  }
}
