import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';
import 'package:very_good_slide_puzzle/colors/colors.dart';
import 'package:very_good_slide_puzzle/l10n/l10n.dart';
import 'package:very_good_slide_puzzle/layout/responsive_layout_builder.dart';
import 'package:very_good_slide_puzzle/models/models.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';
import 'package:very_good_slide_puzzle/typography/typography.dart';

abstract class _TileSize {
  static double small = 75;
  static double medium = 100;
  static double large = 112;
}

/// {@template neon_puzzle_tile}
/// Displays the puzzle tile associated with [tile] and
/// the font size of [tileFontSize] based on the puzzle [state].
/// {@endtemplate}
@visibleForTesting
class NeonPuzzleTile extends StatefulWidget {
  /// {@macro neon_puzzle_tile}
  const NeonPuzzleTile({
    Key? key,
    required this.tile,
    required this.tileFontSize,
    required this.state,
  }) : super(key: key);

  /// The tile to be displayed.
  final Tile tile;

  /// The font size of the tile to be displayed.
  final double tileFontSize;

  /// The state of the puzzle.
  final PuzzleState state;

  @override
  State<NeonPuzzleTile> createState() => _NeonPuzzleTileState();
}

class _NeonPuzzleTileState extends State<NeonPuzzleTile>
    with SingleTickerProviderStateMixin {
  /// Controllers for rive animation playback
  late RiveAnimationController _riveControllerLeft;
  late RiveAnimationController _riveControllerMistake;

  /// Is the animation currently playing?
  bool _isPlayingLeft = false;
  bool _isPlayingMistake = false;

  /// The controller that drives [_scale] animation.
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _riveControllerLeft = OneShotAnimation(
      'left up',
      autoplay: false,
      onStop: () => setState(() => _isPlayingLeft = false),
      onStart: () => setState(() => _isPlayingLeft = true),
    );
    _riveControllerMistake = OneShotAnimation(
      'mistake',
      autoplay: false,
      onStop: () => setState(() => _isPlayingMistake = false),
      onStart: () => setState(() => _isPlayingMistake = true),
    );

    _controller = AnimationController(
      vsync: this,
      duration: PuzzleThemeAnimationDuration.puzzleTileScale,
    );

    _scale = Tween<double>(begin: 1, end: 0.94).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 1, curve: Curves.easeInOut),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.state.puzzle.getDimension();
    const movementDuration = Duration(milliseconds: 500);
    final status = context.select((PuzzleBloc bloc) => bloc.state.puzzleStatus);
    final puzzleIncomplete =
        context.select((PuzzleBloc bloc) => bloc.state.puzzleStatus) ==
            PuzzleStatus.incomplete;
    final hasStarted = status == PuzzleStatus.incomplete;
    final canPress = hasStarted && puzzleIncomplete;

    return AnimatedAlign(
      alignment: FractionalOffset(
        (widget.tile.currentPosition.x - 1) / (size - 1),
        (widget.tile.currentPosition.y - 1) / (size - 1),
      ),
      duration: movementDuration,
      curve: Curves.easeInOut,
      child: ResponsiveLayoutBuilder(
        small: (_, child) => SizedBox.square(
          dimension: _TileSize.small,
          child: child,
        ),
        medium: (_, child) => SizedBox.square(
          dimension: _TileSize.medium,
          child: child,
        ),
        large: (_, child) => SizedBox.square(
          dimension: _TileSize.large,
          child: child,
        ),
        child: (_) => SizedBox.square(
          dimension: _TileSize.large,
          child: MouseRegion(
            onEnter: (_) {
              if (canPress) {
                _controller.forward();
              }
            },
            onExit: (_) {
              if (canPress) {
                _controller.reverse();
              }
            },
            child: ScaleTransition(
              scale: _scale,
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.transparent,
                  textStyle: PuzzleTextStyle.body.copyWith(
                    fontSize: widget.tileFontSize,
                  ),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  padding: EdgeInsets.zero,
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  onSurface: Colors.transparent,
                ).copyWith(
                  foregroundColor:
                      MaterialStateProperty.all(PuzzleColors.white),
                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (states) {
                      return Colors.transparent;
                    },
                  ),
                ),
                onPressed: () {
                  context.read<PuzzleBloc>().add(TileTapped(widget.tile));
                  if (widget.state.puzzle.isTileMovable(widget.tile)) {
                    print('moveable');
                    _riveControllerLeft.isActive = true;
                  } else {
                    print('not moveable');
                    _riveControllerMistake.isActive = true;
                  }
                },
                child: Stack(
                  children: [
                    RiveAnimation.asset(
                      'assets/rive/tile.riv',
                      animations: const [
                        'mistake',
                        'left up',
                      ],
                      controllers: [
                        _riveControllerMistake,
                        _riveControllerLeft,
                      ],
                      fit: BoxFit.cover,
                    ),
                    Center(
                      child: Text(
                        widget.tile.value.toString(),
                        semanticsLabel: context.l10n.puzzleTileLabelText(
                          widget.tile.value.toString(),
                          widget.tile.currentPosition.x.toString(),
                          widget.tile.currentPosition.y.toString(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
