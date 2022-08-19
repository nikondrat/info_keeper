import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomeBodyItemAnimation extends StatelessWidget {
  final Widget bodyItem;
  const HomeBodyItemAnimation({Key? key, required this.bodyItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Animate(
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
          child: bodyItem);
}
