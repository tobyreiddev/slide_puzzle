import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:very_good_slide_puzzle/colors/colors.dart';
import 'package:very_good_slide_puzzle/l10n/l10n.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/models/models.dart';
import 'package:very_good_slide_puzzle/neon/neon.dart';
import 'package:very_good_slide_puzzle/neon/neon_puzzle_board.dart';
import 'package:very_good_slide_puzzle/neon/widgets/background_animations.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';
import 'package:very_good_slide_puzzle/puzzle/widgets/instructions.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';

abstract class _TileFontSize {
  static double small = 36;
  static double medium = 50;
  static double large = 54;
}

/// {@template neon_puzzle_layout_delegate}
/// A delegate for computing the layout of the puzzle UI
/// that uses a [NeonTheme].
/// {@endtemplate}

class NeonPuzzleLayoutDelegate extends PuzzleLayoutDelegate {
  /// {@macro neon_puzzle_layout_delegate}
  const NeonPuzzleLayoutDelegate();

  @override
  Widget startSectionBuilder(PuzzleState state) {
    return ResponsiveLayoutBuilder(
      small: (_, child) => child!,
      medium: (_, child) => child!,
      large: (_, child) => Padding(
        padding: const EdgeInsets.only(left: 50, right: 32),
        child: child,
      ),
      child: (_) => NeonStartSection(state: state),
    );
  }

  @override
  Widget endSectionBuilder(PuzzleState state) {
    return Column(
      children: [
        const ResponsiveGap(
          small: 32,
          medium: 48,
        ),
        ResponsiveLayoutBuilder(
          small: (_, child) => Column(
            children: const [
              NeonPuzzleShuffleButton(),
              SizedBox(height: 16),
              Instructions(),
            ],
          ),
          medium: (_, child) => Column(
            children: const [
              NeonPuzzleShuffleButton(),
              SizedBox(height: 32),
              Instructions(),
            ],
          ),
          large: (_, __) => Column(
            children: const [
              SizedBox(height: 80),
              Instructions(),
            ],
          ),
        ),
        const ResponsiveGap(
          small: 32,
          medium: 48,
        ),
      ],
    );
  }

  @override
  Widget backgroundBuilder(PuzzleState state) {
    return Positioned(
      right: 50,
      bottom: 50,
      child: ResponsiveLayoutBuilder(
        small: (_, __) => const SizedBox(
          width: 118,
          height: 118,
          child: BackgroundAnimations(),
        ),
        medium: (_, __) => const SizedBox(
          width: 214,
          height: 214,
          child: BackgroundAnimations(),
        ),
        large: (_, __) => const SizedBox(
          width: 320,
          height: 320,
          child: BackgroundAnimations(),
        ),
      ),
    );
  }

  @override
  Widget boardBuilder(int size, List<Widget> tiles) {
    return Stack(
      children: [
        Column(
          children: [
            const ResponsiveGap(
              medium: 48,
              large: 96,
            ),
            NeonPuzzleBoard(tiles: tiles),
            const ResponsiveGap(
              large: 96,
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget tileBuilder(Tile tile, PuzzleState state) {
    return ResponsiveLayoutBuilder(
      small: (_, __) => NeonPuzzleTile(
        key: Key('neon_puzzle_tile_${tile.value}_small'),
        tile: tile,
        tileFontSize: _TileFontSize.small,
        state: state,
      ),
      medium: (_, __) => NeonPuzzleTile(
        key: Key('neon_puzzle_tile_${tile.value}_medium'),
        tile: tile,
        tileFontSize: _TileFontSize.medium,
        state: state,
      ),
      large: (_, __) => NeonPuzzleTile(
        key: Key('neon_puzzle_tile_${tile.value}_large'),
        tile: tile,
        tileFontSize: _TileFontSize.large,
        state: state,
      ),
    );
  }

  @override
  Widget whitespaceTileBuilder() {
    return const SizedBox();
  }

  @override
  List<Object?> get props => [];
}

/// {@template neon_start_section}
/// Displays the start section of the puzzle based on [state].
/// {@endtemplate}
@visibleForTesting
class NeonStartSection extends StatelessWidget {
  /// {@macro neon_start_section}
  const NeonStartSection({
    Key? key,
    required this.state,
  }) : super(key: key);

  /// The state of the puzzle.
  final PuzzleState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const ResponsiveGap(
          small: 20,
          medium: 83,
          large: 151,
        ),
        const ResponsiveGap(large: 16),
        NeonPuzzleTitle(
          status: state.puzzleStatus,
        ),
        const ResponsiveGap(
          small: 12,
          medium: 16,
          large: 32,
        ),
        NumberOfMovesAndTilesLeft(
          key: numberOfMovesAndTilesLeftKey,
          numberOfMoves: state.numberOfMoves,
          numberOfTilesLeft: state.numberOfTilesLeft,
          color: const NeonTheme()
              .scoreColor, // TODO: figure out a better way to do this
        ),
        const ResponsiveGap(
          large: 32,
          small: 16,
        ),
        ResponsiveLayoutBuilder(
          small: (_, __) => const SizedBox(),
          medium: (_, __) => const SizedBox(),
          large: (_, __) => const NeonPuzzleShuffleButton(),
        ),
      ],
    );
  }
}

/// {@template neon_puzzle_title}
/// Displays the title of the puzzle based on [status].
///
/// Shows the success state when the puzzle is completed,
/// otherwise defaults to the Puzzle Challenge title.
/// {@endtemplate}
@visibleForTesting
class NeonPuzzleTitle extends StatelessWidget {
  /// {@macro neon_puzzle_title}
  const NeonPuzzleTitle({
    Key? key,
    required this.status,
  }) : super(key: key);

  /// The status of the puzzle.
  final PuzzleStatus status;

  @override
  Widget build(BuildContext context) {
    return PuzzleTitle(
      key: puzzleTitleKey,
      title: context.l10n.puzzleChallengeTitle,
      subtitle: context.l10n.puzzleChallengeSubtitle,
    );
  }
}

/// {@template puzzle_shuffle_button}
/// Displays the button to shuffle the puzzle.
/// {@endtemplate}
@visibleForTesting
class NeonPuzzleShuffleButton extends StatelessWidget {
  /// {@macro puzzle_shuffle_button}
  const NeonPuzzleShuffleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PuzzleButton(
      textColor: NeonPuzzleColors.buttonTextColor,
      backgroundColor: NeonPuzzleColors.selectNeonPink,
      onPressed: () => context.read<PuzzleBloc>().add(const PuzzleReset()),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.repeat),
          const Gap(10),
          Text(context.l10n.puzzleShuffle),
        ],
      ),
    );
  }
}
