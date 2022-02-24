import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';
import 'package:very_good_slide_puzzle/typography/typography.dart';

/// {@template puzzle_title}
/// Displays the title of the puzzle in the given color.
/// {@endtemplate}
class PuzzleTitle extends StatelessWidget {
  /// {@macro puzzle_title}
  const PuzzleTitle({
    Key? key,
    required this.title,
    required this.subtitle,
    this.color,
  }) : super(key: key);

  /// The title to be displayed.
  final String title;

  /// The title to be displayed.
  final String subtitle;

  /// The color of [title], defaults to [PuzzleTheme.titleColor].
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);
    final titleColor = color ?? theme.titleColor;
    final subtitleColor = color ?? theme.subtitleColor;

    return ResponsiveLayoutBuilder(
      small: (context, child) => Center(
        child: SizedBox(
          width: 300,
          child: Center(
            child: child,
          ),
        ),
      ),
      medium: (context, child) => Center(
        child: child,
      ),
      large: (context, child) => SizedBox(
        width: 300,
        child: child,
      ),
      child: (currentSize) {
        final textStyle = (currentSize == ResponsiveLayoutSize.large
                ? PuzzleTextStyle.headline1.copyWith(fontSize: 92)
                : PuzzleTextStyle.headline1.copyWith(fontSize: 86))
            .copyWith(
          shadows: [
            Shadow(
              color: titleColor,
              blurRadius: 20,
            )
          ],
          foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 0.1
            ..color = titleColor,
        );

        final subtitleTextStyle = (currentSize == ResponsiveLayoutSize.large
                ? PuzzleTextStyle.headline2.copyWith(fontSize: 55)
                : PuzzleTextStyle.headline2.copyWith(fontSize: 42))
            .copyWith(
          color: subtitleColor,
          shadows: [
            Shadow(
              color: subtitleColor,
              blurRadius: 10,
            )
          ],
        );

        final textAlign = currentSize == ResponsiveLayoutSize.small
            ? TextAlign.center
            : TextAlign.left;

        return Column(
          children: [
            AnimatedDefaultTextStyle(
              style: textStyle,
              duration: PuzzleThemeAnimationDuration.textStyle,
              child: Text(
                title,
                textAlign: textAlign,
              ),
            ),
            AnimatedDefaultTextStyle(
              style: subtitleTextStyle,
              duration: PuzzleThemeAnimationDuration.textStyle,
              child: Text(
                subtitle,
                textAlign: textAlign,
              ),
            ),
          ],
        );
      },
    );
  }
}
