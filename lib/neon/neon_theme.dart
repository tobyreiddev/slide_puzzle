import 'dart:ui';

import 'package:very_good_slide_puzzle/colors/colors.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/neon/neon.dart';
import 'package:very_good_slide_puzzle/theme/themes/themes.dart';

/// {@template neon_theme}
/// The neon puzzle theme.
/// {@endtemplate}
class NeonTheme extends PuzzleTheme {
  /// {@macro neon_theme}
  const NeonTheme() : super();

  @override
  String get name => 'Neon';

  @override
  bool get hasTimer => false;

  @override
  Color get nameColor => NeonPuzzleColors.neonBlue;

  @override
  Color get titleColor => NeonPuzzleColors.neonBlue;

  @override
  Color get subtitleColor => NeonPuzzleColors.neonGreen;

  @override
  Color get backgroundColor => NeonPuzzleColors.darkGrey;

  @override
  Color get defaultColor => NeonPuzzleColors.darkestNeonPink;

  /// The text color of the score.
  ///
  /// Applied to the text color of the score.
  Color get scoreColor => NeonPuzzleColors.greyMed;

  @override
  Color get buttonColor => NeonPuzzleColors.button;

  @override
  Color get hoverColor => NeonPuzzleColors.mediumNeonPink;

  @override
  Color get pressedColor => NeonPuzzleColors.darkestNeonPink;

  @override
  bool get isLogoColored => true;

  @override
  Color get menuActiveColor => NeonPuzzleColors.neonPink;

  @override
  Color get menuUnderlineColor => NeonPuzzleColors.neonPink;

  @override
  Color get menuInactiveColor => NeonPuzzleColors.greyMed;

  @override
  String get audioControlOnAsset => 'assets/images/audio_control/simple_on.png';

  @override
  String get audioControlOffAsset =>
      'assets/images/audio_control/simple_off.png';

  @override
  PuzzleLayoutDelegate get layoutDelegate => const NeonPuzzleLayoutDelegate();

  @override
  List<Object?> get props => [
        name,
        audioControlOnAsset,
        audioControlOffAsset,
        hasTimer,
        nameColor,
        titleColor,
        backgroundColor,
        defaultColor,
        buttonColor,
        hoverColor,
        pressedColor,
        isLogoColored,
        menuActiveColor,
        menuUnderlineColor,
        menuInactiveColor,
        layoutDelegate,
      ];
}
