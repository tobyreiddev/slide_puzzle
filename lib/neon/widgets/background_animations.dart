import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:very_good_slide_puzzle/models/models.dart';

///

final animations = <AnimationModel>[
  const AnimationModel(
    path: 'assets/rive/flamingo_V2.riv',
    name: 'flamingo_animation',
  ),
  const AnimationModel(
    path: 'assets/rive/palm_V2.riv',
    name: 'palm_animation',
  ),
  const AnimationModel(
    path: 'assets/rive/planet_V2.riv',
    name: 'planet_animation',
  ),
];

/// {@template background_animations}
/// Displays rive animations as part of the PuzzlePage.
/// {@endtemplate}
class BackgroundAnimations extends StatefulWidget {
  /// {@macro background_animations}
  const BackgroundAnimations({Key? key}) : super(key: key);

  @override
  State<BackgroundAnimations> createState() => _BackgroundAnimationsState();
}

class _BackgroundAnimationsState extends State<BackgroundAnimations> {
  // Controller for playback
  late RiveAnimationController _controller;
  late AnimationModel _animationData;

  @override
  void initState() {
    super.initState();

    _animationData = animations[Random().nextInt(animations.length)];
    _controller = SimpleAnimation(_animationData.name);
  }

  @override
  Widget build(BuildContext context) {
    return RiveAnimation.asset(
      _animationData.path,
      animations: [
        _animationData.name,
      ],
      controllers: [_controller],
      alignment: Alignment.bottomRight,
    );
  }
}
