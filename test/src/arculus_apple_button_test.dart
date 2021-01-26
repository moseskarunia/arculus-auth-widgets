import 'package:arculus_auth_widgets/arculus_auth_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('backgroundColor, foregroundColor, icon', () {
    group('if Brightness.light', () {
      testWidgets(
        'should be black, white, white',
        (tester) async {
          await tester.pumpWidget(MaterialApp(
            home: Scaffold(
              body: ArculusAppleButton(
                label: 'Continue with Apple',
              ),
            ),
          ));

          final button = tester
              .widget<ElevatedButton>(find.byKey(Key('arculus-base-button')));

          expect(button.style.backgroundColor.resolve({}), Colors.black);
          expect(find.byKey(Key('apple-icon-white')), findsOneWidget);
          expect(button.style.foregroundColor.resolve({}), Colors.white);
        },
      );

      testWidgets(
        'and isLoading, should be black with 0.5 opacity, '
        'white with 0.5 opacity, white',
        (tester) async {
          await tester.pumpWidget(MaterialApp(
            home: Scaffold(
              body: ArculusAppleButton(
                label: 'Continue with Apple',
                isLoading: true,
              ),
            ),
          ));

          final button = tester
              .widget<ElevatedButton>(find.byKey(Key('arculus-base-button')));

          expect(button.style.backgroundColor.resolve({MaterialState.disabled}),
              Colors.black.withOpacity(0.5));
          expect(find.byKey(Key('apple-icon-white')), findsOneWidget);
          expect(button.style.foregroundColor.resolve({MaterialState.disabled}),
              Colors.white.withOpacity(0.5));
        },
      );
    });

    group('if Brightness.dark', () {
      testWidgets(
        'should be white, black, black',
        (tester) async {
          await tester.pumpWidget(MaterialApp(
            themeMode: ThemeMode.dark,
            darkTheme: ThemeData(brightness: Brightness.dark),
            home: Scaffold(
              body: ArculusAppleButton(
                label: 'Continue with Apple',
              ),
            ),
          ));

          final button = tester
              .widget<ElevatedButton>(find.byKey(Key('arculus-base-button')));

          expect(button.style.backgroundColor.resolve({}), Colors.white);
          expect(find.byKey(Key('apple-icon-black')), findsOneWidget);
          expect(button.style.foregroundColor.resolve({}), Colors.black);
        },
      );

      testWidgets(
        'and isLoading, should be white with 0.5 opacity, '
        'black with 0.5 opacity, black',
        (tester) async {
          await tester.pumpWidget(MaterialApp(
            themeMode: ThemeMode.dark,
            darkTheme: ThemeData(brightness: Brightness.dark),
            home: Scaffold(
              body: ArculusAppleButton(
                label: 'Continue with Apple',
                isLoading: true,
              ),
            ),
          ));

          final button = tester
              .widget<ElevatedButton>(find.byKey(Key('arculus-base-button')));

          expect(button.style.backgroundColor.resolve({MaterialState.disabled}),
              Colors.white.withOpacity(0.5));
          expect(find.byKey(Key('apple-icon-black')), findsOneWidget);
          expect(button.style.foregroundColor.resolve({MaterialState.disabled}),
              Colors.black.withOpacity(0.5));
        },
      );
    });
  });
}
