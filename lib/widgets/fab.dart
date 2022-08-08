import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:info_keeper/model/controller.dart';

@immutable
class ExpandableFab extends StatefulWidget {
  const ExpandableFab(
      {super.key,
      this.initialOpen,
      required this.distance,
      required this.children,
      required this.controller});

  final bool? initialOpen;
  final double distance;
  final List<Widget> children;
  final AnimationController controller;

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late final Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    Controller.to.isShowDial.value = widget.initialOpen ?? false;
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: widget.controller,
    );
  }

  void _toggle() {
    setState(() {
      Controller.to.isShowDial.value = !Controller.to.isShowDial.value;
      if (Controller.to.isShowDial.value) {
        widget.controller.forward();
      } else {
        widget.controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.none,
        children: [
          ..._buildExpandingActionButtons(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
            child: _buildTapToOpenFab(),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildExpandingActionButtons() {
    final children = <Widget>[];
    final count = widget.children.length;
    final step = 90 / (count - 1);
    for (var i = 0, angleInDegrees = 18.0;
        i < count;
        i++, angleInDegrees += step) {
      children.add(
        _ExpandingActionButton(
          directionInDegrees: angleInDegrees,
          maxDistance: widget.distance,
          progress: _expandAnimation,
          child: widget.children[i],
        ),
      );
    }
    return children;
  }

  Widget _buildTapToOpenFab() {
    return AnimatedContainer(
      transformAlignment: Alignment.center,
      duration: const Duration(milliseconds: 250),
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      child: FloatingActionButton(
        heroTag: Controller.to.isShowDial.value ? 'open' : 'close',
        onPressed: () {
          _toggle();
        },
        child: Icon(Controller.to.isShowDial.value ? Icons.close : Icons.add),
      ),
    );
  }
}

@immutable
class _ExpandingActionButton extends StatelessWidget {
  const _ExpandingActionButton({
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
  });

  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          directionInDegrees * (math.pi / 180.0),
          progress.value * maxDistance,
        );
        return Positioned(
          right: 20.0 + offset.dx,
          bottom: 20.0 + offset.dy,
          child: Transform.rotate(
            angle: (1.0 - progress.value) * math.pi / 2,
            child: child!,
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}

@immutable
class ActionButton extends StatelessWidget {
  const ActionButton(
      {super.key,
      this.onPressed,
      required this.icon,
      required this.heroTag,
      required this.controller});

  final VoidCallback? onPressed;
  final Widget icon;
  final String heroTag;
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: heroTag,
      onPressed: onPressed,
      mini: true,
      child: icon,
    );
  }
}
