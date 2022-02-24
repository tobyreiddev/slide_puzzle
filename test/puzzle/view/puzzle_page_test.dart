// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_slide_puzzle/audio_control/audio_control.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';
import 'package:very_good_slide_puzzle/simple/simple.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';
import 'package:very_good_slide_puzzle/timer/timer.dart';

import '../../helpers/helpers.dart';

void main() {
  group('PuzzlePage', () {
    testWidgets('renders PuzzleView', (tester) async {
      await tester.pumpApp(PuzzlePage());
      expect(find.byType(PuzzleView), findsOneWidget);
    });

    testWidgets('provides correct initial themes to PuzzleView',
        (tester) async {
      await tester.pumpApp(PuzzlePage());

      final BuildContext puzzleViewContext =
          tester.element(find.byType(PuzzleView));

      final initialThemes = puzzleViewContext.read<ThemeBloc>().state.themes;

      expect(
        initialThemes,
        equals([
          SimpleTheme(),
        ]),
      );
    });

    testWidgets(
        'provides TimerBloc '
        'with initial state', (tester) async {
      await tester.pumpApp(PuzzlePage());

      final BuildContext puzzleViewContext =
          tester.element(find.byType(PuzzleView));

      expect(
        puzzleViewContext.read<TimerBloc>().state,
        equals(TimerState()),
      );
    });

    testWidgets(
        'provides AudioControlBloc '
        'with initial state', (tester) async {
      await tester.pumpApp(PuzzlePage());

      final BuildContext puzzleViewContext =
          tester.element(find.byType(PuzzleView));

      expect(
        puzzleViewContext.read<AudioControlBloc>().state,
        equals(AudioControlState()),
      );
    });
  });

  group('PuzzleView', () {
    late ThemeBloc themeBloc;
    late PuzzleTheme theme;
    late PuzzleLayoutDelegate layoutDelegate;
    late AudioControlBloc audioControlBloc;

    setUp(() {
      theme = MockPuzzleTheme();
      final themeState = ThemeState(themes: [theme], theme: theme);
      themeBloc = MockThemeBloc();
      layoutDelegate = MockPuzzleLayoutDelegate();

      when(() => layoutDelegate.startSectionBuilder(any()))
          .thenReturn(SizedBox());

      when(() => layoutDelegate.endSectionBuilder(any()))
          .thenReturn(SizedBox());

      when(() => layoutDelegate.backgroundBuilder(any()))
          .thenReturn(SizedBox());

      when(() => layoutDelegate.boardBuilder(any(), any()))
          .thenReturn(SizedBox());

      when(() => layoutDelegate.tileBuilder(any(), any()))
          .thenReturn(SizedBox());

      when(layoutDelegate.whitespaceTileBuilder).thenReturn(SizedBox());

      when(() => theme.layoutDelegate).thenReturn(layoutDelegate);
      when(() => theme.backgroundColor).thenReturn(Colors.black);
      when(() => theme.isLogoColored).thenReturn(true);
      when(() => theme.menuActiveColor).thenReturn(Colors.black);
      when(() => theme.menuUnderlineColor).thenReturn(Colors.black);
      when(() => theme.menuInactiveColor).thenReturn(Colors.black);
      when(() => theme.hasTimer).thenReturn(true);
      when(() => theme.name).thenReturn('Name');
      when(() => theme.audioControlOnAsset)
          .thenReturn('assets/images/audio_control/simple_on.png');
      when(() => theme.audioControlOffAsset)
          .thenReturn('assets/images/audio_control/simple_off.png');
      when(() => themeBloc.state).thenReturn(themeState);

      audioControlBloc = MockAudioControlBloc();
      when(() => audioControlBloc.state).thenReturn(AudioControlState());
    });

    setUpAll(() {
      registerFallbackValue(MockPuzzleState());
      registerFallbackValue(MockTile());
    });

    group('PuzzleSections', () {
      late PuzzleBloc puzzleBloc;

      setUp(() {
        final puzzleState = MockPuzzleState();
        final puzzle = MockPuzzle();
        puzzleBloc = MockPuzzleBloc();

        when(puzzle.getDimension).thenReturn(4);
        when(() => puzzle.tiles).thenReturn([]);
        when(() => puzzleState.puzzle).thenReturn(puzzle);
        when(() => puzzleState.puzzleStatus).thenReturn(PuzzleStatus.complete);
        whenListen(
          puzzleBloc,
          Stream.value(puzzleState),
          initialState: puzzleState,
        );
      });

      group('on a large display', () {
        testWidgets(
            'builds start section '
            'with layoutDelegate.startSectionBuilder', (tester) async {
          tester.setLargeDisplaySize();

          await tester.pumpApp(
            PuzzleSections(),
            themeBloc: themeBloc,
            puzzleBloc: puzzleBloc,
            audioControlBloc: audioControlBloc,
          );

          verify(() => layoutDelegate.startSectionBuilder(any())).called(1);
        });

        testWidgets(
            'builds end section '
            'with layoutDelegate.endSectionBuilder', (tester) async {
          tester.setLargeDisplaySize();

          await tester.pumpApp(
            PuzzleSections(),
            themeBloc: themeBloc,
            puzzleBloc: puzzleBloc,
            audioControlBloc: audioControlBloc,
          );

          verify(() => layoutDelegate.endSectionBuilder(any())).called(1);
        });

        testWidgets('renders PuzzleBoard', (tester) async {
          tester.setLargeDisplaySize();

          await tester.pumpApp(
            PuzzleSections(),
            themeBloc: themeBloc,
            puzzleBloc: puzzleBloc,
            audioControlBloc: audioControlBloc,
          );

          expect(find.byType(PuzzleBoard), findsOneWidget);
        });
      });

      group('on a medium display', () {
        testWidgets(
            'builds start section '
            'with layoutDelegate.startSectionBuilder', (tester) async {
          tester.setMediumDisplaySize();

          await tester.pumpApp(
            PuzzleSections(),
            themeBloc: themeBloc,
            puzzleBloc: puzzleBloc,
            audioControlBloc: audioControlBloc,
          );

          verify(() => layoutDelegate.startSectionBuilder(any())).called(1);
        });

        testWidgets(
            'builds end section '
            'with layoutDelegate.endSectionBuilder', (tester) async {
          tester.setMediumDisplaySize();

          await tester.pumpApp(
            PuzzleSections(),
            themeBloc: themeBloc,
            puzzleBloc: puzzleBloc,
            audioControlBloc: audioControlBloc,
          );

          verify(() => layoutDelegate.endSectionBuilder(any())).called(1);
        });

        testWidgets('renders PuzzleBoard', (tester) async {
          tester.setMediumDisplaySize();

          await tester.pumpApp(
            PuzzleSections(),
            themeBloc: themeBloc,
            puzzleBloc: puzzleBloc,
            audioControlBloc: audioControlBloc,
          );

          expect(find.byType(PuzzleBoard), findsOneWidget);
        });
      });

      group('on a small display', () {
        testWidgets(
            'builds start section '
            'with layoutDelegate.startSectionBuilder', (tester) async {
          tester.setSmallDisplaySize();

          await tester.pumpApp(
            PuzzleSections(),
            themeBloc: themeBloc,
            puzzleBloc: puzzleBloc,
            audioControlBloc: audioControlBloc,
          );

          verify(() => layoutDelegate.startSectionBuilder(any())).called(1);
        });

        testWidgets(
            'builds end section '
            'with layoutDelegate.endSectionBuilder', (tester) async {
          tester.setSmallDisplaySize();

          await tester.pumpApp(
            PuzzleSections(),
            themeBloc: themeBloc,
            puzzleBloc: puzzleBloc,
            audioControlBloc: audioControlBloc,
          );

          verify(() => layoutDelegate.endSectionBuilder(any())).called(1);
        });

        testWidgets('renders PuzzleBoard', (tester) async {
          tester.setSmallDisplaySize();

          await tester.pumpApp(
            PuzzleSections(),
            themeBloc: themeBloc,
            puzzleBloc: puzzleBloc,
            audioControlBloc: audioControlBloc,
          );

          expect(find.byType(PuzzleBoard), findsOneWidget);
        });
      });
    });

    group('PuzzleBoard', () {
      late PuzzleBloc puzzleBloc;

      setUp(() {
        puzzleBloc = MockPuzzleBloc();
        final puzzleState = MockPuzzleState();
        final puzzle = MockPuzzle();

        when(puzzle.getDimension).thenReturn(4);
        when(() => puzzle.tiles).thenReturn([]);
        when(() => puzzleState.puzzle).thenReturn(puzzle);
        when(() => puzzleState.puzzleStatus).thenReturn(PuzzleStatus.complete);
        whenListen(
          puzzleBloc,
          Stream.value(puzzleState),
          initialState: puzzleState,
        );
      });

      testWidgets('renders PuzzleKeyboardHandler', (tester) async {
        await tester.pumpApp(
          PuzzleBoard(),
          themeBloc: themeBloc,
          puzzleBloc: puzzleBloc,
          audioControlBloc: audioControlBloc,
        );

        expect(find.byType(PuzzleKeyboardHandler), findsOneWidget);
      });
    });
  });
}
