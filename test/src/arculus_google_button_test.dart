import 'package:arculus_auth_widgets/arculus_auth_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('backgroundColor, foregroundColor, icon', () {
    group('if Brightness.light', () {
      testWidgets(
        'should be white, black, with backgroundless icon',
        (tester) async {
          await tester.pumpWidget(MaterialApp(
            home: Scaffold(
              body: ArculusGoogleButton(
                label: 'Continue with Google',
                onPressed: (_) {},
              ),
            ),
          ));

          final button = tester
              .widget<ElevatedButton>(find.byKey(Key('arculus-base-button')));

          expect(button.style.backgroundColor.resolve({}), Colors.white);
          expect(find.byKey(Key('google-icon')), findsOneWidget);
          expect(button.style.foregroundColor.resolve({}), Colors.black);
        },
      );

      testWidgets(
        'and isLoading, should be white with 0.5 opacity, '
        'black with 0.5 opacity, backgroundless icon',
        (tester) async {
          await tester.pumpWidget(MaterialApp(
            home: Scaffold(
              body: ArculusGoogleButton(
                label: 'Continue with Google',
                isLoading: true,
              ),
            ),
          ));

          final button = tester
              .widget<ElevatedButton>(find.byKey(Key('arculus-base-button')));

          expect(button.style.backgroundColor.resolve({MaterialState.disabled}),
              Colors.white.withOpacity(0.5));
          expect(find.byKey(Key('google-icon')), findsOneWidget);
          expect(button.style.foregroundColor.resolve({MaterialState.disabled}),
              Colors.black.withOpacity(0.5));
          expect(find.byKey(Key('google-icon-background')), findsNothing);
        },
      );
    });

    group('if Brightness.dark', () {
      testWidgets(
        'should be white, black, backgrounded icon',
        (tester) async {
          await tester.pumpWidget(MaterialApp(
            themeMode: ThemeMode.dark,
            darkTheme: ThemeData(brightness: Brightness.dark),
            home: Scaffold(
              body: ArculusGoogleButton(
                label: 'Continue with Google',
                onPressed: (_) {},
              ),
            ),
          ));

          final button = tester
              .widget<ElevatedButton>(find.byKey(Key('arculus-base-button')));

          expect(button.style.backgroundColor.resolve({}), Color(0xFF4285F4));
          expect(find.byKey(Key('google-icon')), findsOneWidget);
          expect(button.style.foregroundColor.resolve({}), Colors.white);

          final background = find.byKey(Key('google-icon-background'));
          expect(background, findsOneWidget);
          expect(
            (tester.widget<Container>(background).decoration as BoxDecoration)
                .color,
            Colors.white,
          );
        },
      );

      testWidgets(
        'and isLoading, should be white with 0.5 opacity, '
        'black with 0.5 opacity, translucently backgrounded icon',
        (tester) async {
          await tester.pumpWidget(MaterialApp(
            themeMode: ThemeMode.dark,
            darkTheme: ThemeData(brightness: Brightness.dark),
            home: Scaffold(
              body: ArculusGoogleButton(
                label: 'Continue with Google',
                isLoading: true,
              ),
            ),
          ));

          final button = tester
              .widget<ElevatedButton>(find.byKey(Key('arculus-base-button')));

          expect(button.style.backgroundColor.resolve({MaterialState.disabled}),
              Color(0xFF4285F4).withOpacity(0.5));
          expect(find.byKey(Key('google-icon')), findsOneWidget);
          expect(button.style.foregroundColor.resolve({MaterialState.disabled}),
              Colors.white.withOpacity(0.5));

          final background = find.byKey(Key('google-icon-background'));
          expect(background, findsOneWidget);
          expect(
            (tester.widget<Container>(background).decoration as BoxDecoration)
                .color,
            Colors.white.withOpacity(0.5),
          );
        },
      );
    });

    group('icon background', () {
      testWidgets(
        'should have 2 margin and 14 padding',
        (tester) async {
          await tester.pumpWidget(MaterialApp(
            themeMode: ThemeMode.dark,
            darkTheme: ThemeData(brightness: Brightness.dark),
            home: Scaffold(
              body: ArculusGoogleButton(
                label: 'Continue with Google',
                isLoading: true,
              ),
            ),
          ));

          final background = find.byKey(Key('google-icon-background'));
          final container = tester.widget<Container>(background);

          expect(container.margin, EdgeInsets.all(2));
          expect(container.padding, EdgeInsets.all(14));
        },
      );

      group('borderRadius', () {
        testWidgets('should copy from ElevatedButtonTheme', (tester) async {
          await tester.pumpWidget(MaterialApp(
            themeMode: ThemeMode.dark,
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ButtonStyle(
                  shape: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> states) {
                      return RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      );
                    },
                  ),
                ),
              ),
            ),
            home: Scaffold(
              body: ArculusGoogleButton(
                label: 'Continue with Google',
                isLoading: true,
              ),
            ),
          ));

          final background = find.byKey(Key('google-icon-background'));
          final container = tester.widget<Container>(background);
          expect((container.decoration as BoxDecoration).borderRadius,
              BorderRadius.circular(24));
        });
        testWidgets('should copy from ButtonTheme', (tester) async {
          await tester.pumpWidget(MaterialApp(
            themeMode: ThemeMode.dark,
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              buttonTheme: ButtonThemeData(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            home: Scaffold(
              body: ArculusGoogleButton(
                label: 'Continue with Google',
                isLoading: true,
              ),
            ),
          ));

          final background = find.byKey(Key('google-icon-background'));
          final container = tester.widget<Container>(background);
          expect((container.decoration as BoxDecoration).borderRadius,
              BorderRadius.circular(16));
        });
      });
    });
  });

  group('accent color', () {
    testWidgets(
      'should be Color(0xFF4285F4).withOpacity(0.5) if Brightness.light',
      (tester) async {
        await tester.pumpWidget(MaterialApp(
          home: Scaffold(
            body: ArculusGoogleButton(
              label: 'Continue with Google',
              onPressed: (_) {},
            ),
          ),
        ));

        final theme = find
            .descendant(
              of: find.byKey(Key('arculus-google-button')),
              matching: find.byType(Theme),
            )
            .first;

        expect(
          tester.widget<Theme>(theme).data.accentColor,
          Color(0xFF4285F4).withOpacity(0.5),
        );
      },
    );
    testWidgets(
      'should matches primaryTextTheme button color if Brightness.dark',
      (tester) async {
        await tester.pumpWidget(MaterialApp(
          themeMode: ThemeMode.dark,
          darkTheme: ThemeData(brightness: Brightness.dark),
          home: Scaffold(
            body: ArculusGoogleButton(
              label: 'Continue with Google',
              isLoading: true,
              onPressed: (_) {},
            ),
          ),
        ));

        final theme = find
            .descendant(
              of: find.byKey(Key('arculus-google-button')),
              matching: find.byType(Theme),
            )
            .first;
        final themeData = tester.widget<Theme>(theme).data;

        expect(
          themeData.accentColor,
          themeData.primaryTextTheme.button.color.withOpacity(0.5),
        );
      },
    );
  });
}
