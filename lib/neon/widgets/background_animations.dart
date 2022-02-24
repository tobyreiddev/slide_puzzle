import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class BackgroundAnimations extends StatefulWidget {
  const BackgroundAnimations({Key? key}) : super(key: key);

  @override
  State<BackgroundAnimations> createState() => _BackgroundAnimationsState();
}

class _BackgroundAnimationsState extends State<BackgroundAnimations> {
  // Controller for playback
  late RiveAnimationController _controller;

  // Toggles between play and pause animation states
  void _togglePlay() =>
      setState(() => _controller.isActive = !_controller.isActive);

  /// Tracks if the animation is playing by whether controller is running
  bool get isPlaying => _controller.isActive;

  @override
  void initState() {
    super.initState();
    _controller = SimpleAnimation('idle');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RiveAnimation.asset(
        'assets/rive/neon_animations_left.riv',
        animations: const [
          'Idle',
        ],
        controllers: [_controller],
        fit: BoxFit.cover,
      ),
    );
  }
}
