import 'package:flutter/widgets.dart';

/// Defines the color palette for the puzzle UI.
abstract class PuzzleColors {
  /// Primary 1
  static const Color primary1 = Color(0xFF041E3C);

  /// Primary 2
  static const Color primary2 = Color(0xFF042B59);

  /// Primary 3
  static const Color primary3 = Color(0xFF043875);

  /// Primary 4
  static const Color primary4 = Color(0xFF0553B1);

  /// Primary 5
  static const Color primary5 = Color(0xFF0468D7);

  /// Primary 6
  static const Color primary6 = Color(0xFF027DFD);

  /// Primary 7
  static const Color primary7 = Color(0xFF13B9FD);

  /// Primary 8
  static const Color primary8 = Color(0xFFB8EAFE);

  /// Primary 9
  static const Color primary9 = Color(0xFFE7F8FF);

  /// Primary 0
  static const Color primary0 = Color(0xFFFFFFFF);

  /// Black
  static const Color black = Color(0xFF000000);

  /// Black 2 (opacity 20%)
  static const Color black2 = Color(0x33000000);

  /// Grey 1
  static const Color grey1 = Color(0xFF4A4A4A);

  /// Grey 2
  static const Color grey2 = Color(0xFFA4A4A4);

  /// Grey 3
  static const Color grey3 = Color(0xFFE8EAED);

  /// Grey 4
  static const Color grey4 = Color(0xFFF1F3F4);

  /// Grey 5
  static const Color grey5 = Color(0xFFF8F9FA);

  /// White
  static const Color white = Color(0xFFFFFFFF);

  /// White 2 (opacity 40%)
  static const Color white2 = Color(0x66FFFFFF);

  /// Green primary
  static const Color greenPrimary = Color(0xFF00504C);

  /// Green 90
  static const Color green90 = Color(0xFF71F7EF);

  /// Green 50
  static const Color green50 = Color(0xFF00857F);

  /// Blue primary
  static const Color bluePrimary = Color(0xFF003064);

  /// Blue 90
  static const Color blue90 = Color(0xFF75BFFF);

  /// Blue 50
  static const Color blue50 = Color(0xFF027DFD);

  /// Yellow primary
  static const Color yellowPrimary = Color(0xFF676000);

  /// Yellow 90
  static const Color yellow90 = Color(0xFFFFF475);

  /// Yellow 50
  static const Color yellow50 = Color(0xFF9E9400);
}

/// Defines the color palette for the puzzle UI.
abstract class NeonPuzzleColors {
  /// Dark Grey
  static const Color darkGrey = Color(0xFF121212);

  /// Grey High
  static const Color greyHigh = Color(0xFFE0E0E0);

  /// Grey Medium
  static const Color greyMed = Color(0xFFA0A0A0);

  /// Grey Disabled
  static const Color greyDisabled = Color(0xFF6C6C6C);

  /// Text Regular
  static const Color textRegular = Color(0xFFA0A0A0);

  /// Surface
  static const Color surface = Color(0xFF121212);

  /// Button
  static const Color button = Color(0xFFFCFCFC);

  /// Neon green
  static const Color neonGreen = Color(0xFFC0FC3F);

  /// Neon blue
  static const Color neonBlue = Color(0xFF3AFAFC);

  /// Neon pink
  static const Color neonPink = Color(0xFFE23FF7);

  /// Medium neon pink
  static const Color mediumNeonPink = Color(0xFF6E2576);

  /// Darkest neon pink
  static const Color darkestNeonPink = Color(0xFF3B1A3F);

  /// Select neon pink
  static const Color selectNeonPink = Color(0xFFAD33BE);

  /// Neon yellow
  static const Color neonYellow = Color(0xFFFFE027);

  /// Shadow
  static const Color shadow = Color(0xFF000000);

  /// Button text color
  static const Color buttonTextColor = NeonPuzzleColors.button;

  /// Button background color
  static const Color buttonBackgroundColor = NeonPuzzleColors.neonPink;
}
