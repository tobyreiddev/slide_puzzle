import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_slide_puzzle/colors/colors.dart';
import 'package:very_good_slide_puzzle/l10n/l10n.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';
import 'package:very_good_slide_puzzle/typography/typography.dart';

/// Button to show bottom sheet modal with instructions on how to play
class Instructions extends StatelessWidget {
  /// Button to show bottom sheet modal with instructions on how to play
  const Instructions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);
    return IconButton(
      icon: const Icon(
        Icons.info_outline,
        color: NeonPuzzleColors.greyMed,
      ),
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return Container(
              color: theme.backgroundColor,
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  child: Text(
                                    context.l10n.neonGoalTitle,
                                    style: PuzzleTextStyle.headline2.copyWith(
                                      color: theme.subtitleColor,
                                      fontSize: 32,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 32),
                                Flexible(
                                  child: Text(
                                    context.l10n.neonGoalText,
                                    style: PuzzleTextStyle.bodySmall.copyWith(
                                      color: theme.buttonColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  context.l10n.neonInstructionsTitle,
                                  style: PuzzleTextStyle.headline2.copyWith(
                                    color: theme.subtitleColor,
                                    fontSize: 32,
                                  ),
                                ),
                                const SizedBox(height: 32),
                                Flexible(
                                  child: Text(
                                    context.l10n.neonInstructionsText,
                                    style: PuzzleTextStyle.bodySmall.copyWith(
                                      color: theme.buttonColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: () => Navigator.pop(context),
                      highlightColor: theme.defaultColor,
                      color: theme.defaultColor,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      highlightColor: theme.defaultColor,
      color: theme.defaultColor,
    );
  }
}
