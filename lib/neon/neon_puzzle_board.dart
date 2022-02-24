import 'package:flutter/material.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';

abstract class _BoardSize {
  static double small = 312;
  static double medium = 424;
  static double large = 472;
}

/// {@template dashatar_puzzle_board}
/// Displays the board of the puzzle in a [Stack] filled with [tiles].
/// {@endtemplate}
class NeonPuzzleBoard extends StatefulWidget {
  /// {@macro dashatar_puzzle_board}
  const NeonPuzzleBoard({
    Key? key,
    required this.tiles,
  }) : super(key: key);

  /// The tiles to be displayed on the board.
  final List<Widget> tiles;

  @override
  State<NeonPuzzleBoard> createState() => _NeonPuzzleBoardState();
}

class _NeonPuzzleBoardState extends State<NeonPuzzleBoard> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutBuilder(
      small: (_, child) => SizedBox.square(
        key: const Key('neon_puzzle_board_small'),
        dimension: _BoardSize.small,
        child: child,
      ),
      medium: (_, child) => SizedBox.square(
        key: const Key('neon_puzzle_board_medium'),
        dimension: _BoardSize.medium,
        child: child,
      ),
      large: (_, child) => SizedBox.square(
        key: const Key('neon_puzzle_board_large'),
        dimension: _BoardSize.large,
        child: child,
      ),
      child: (_) => Stack(children: widget.tiles),
    );
  }
}
