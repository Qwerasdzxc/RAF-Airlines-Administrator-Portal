import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

enum _AniProps { opacity, translateX }

class FadeInWidget extends StatelessWidget {
  final double delay;
  final Widget child;
  final bool yAxis;

  FadeInWidget({@required this.child, this.delay = 0, this.yAxis = false});

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<_AniProps>()
      ..add(_AniProps.opacity, Tween(begin: 0.0, end: 1.0))
      ..add(_AniProps.translateX, Tween(begin: 130.0, end: 0.0));

    return PlayAnimation<MultiTweenValues<_AniProps>>(
      delay: Duration(milliseconds: (200 * delay).round()),
      duration: Duration(milliseconds: 225),
      tween: tween,
      child: child,
      builder: (context, child, value) => Opacity(
        opacity: value.get(_AniProps.opacity),
        child: Transform.translate(
          offset: !yAxis ? Offset(value.get(_AniProps.translateX), 0) : Offset(0, -value.get(_AniProps.translateX)),
          child: child,
        ),
      ),
    );
  }
}