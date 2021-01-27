import 'package:arculus_auth_widgets/arculus_auth_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('backgroundColor', () {
    testWidgets(
      'should creates new ElevatedButton theme, '
      'and overrides its backgroundColor using primaryColor',
      (tester) async {
        await tester.pumpWidget(MaterialApp(
          theme: ThemeData(primaryColor: Colors.orange),
          home: Scaffold(
            body: ArculusPrimaryButton(
              label: 'Continue with Email',
              onPressed: (_) {},
            ),
          ),
        ));

        final themeFinder = find
            .descendant(
              of: find.byKey(Key('arculus-primary-button')),
              matching: find.byType(Theme),
            )
            .first;
        final theme = tester.widget<Theme>(themeFinder);

        expect(
          theme.data.elevatedButtonTheme.style.backgroundColor.resolve({}),
          Colors.orange,
        );
      },
    );
    testWidgets(
      'should copy from the root ElevatedButton theme, '
      'and overrides its backgroundColor using primaryColor',
      (tester) async {
        await tester.pumpWidget(MaterialApp(
          theme: ThemeData(
            primaryColor: Colors.red,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                elevation:
                    MaterialStateProperty.resolveWith<double>((s) => 0.0),
              ),
            ),
          ),
          home: Scaffold(
            body: ArculusPrimaryButton(
              label: 'Continue with Email',
              onPressed: (_) {},
            ),
          ),
        ));

        final themeFinder = find
            .descendant(
              of: find.byKey(Key('arculus-primary-button')),
              matching: find.byType(Theme),
            )
            .first;
        final theme = tester.widget<Theme>(themeFinder);

        expect(
          theme.data.elevatedButtonTheme.style.backgroundColor.resolve({}),
          Colors.red,
        );
        expect(theme.data.elevatedButtonTheme.style.elevation.resolve({}), 0.0);
      },
    );

    testWidgets(
      'if disabled, should have opacity 0.5',
      (tester) async {
        await tester.pumpWidget(MaterialApp(
          theme: ThemeData(primaryColor: Colors.red),
          home: Scaffold(
            body: ArculusPrimaryButton(
              label: 'Continue with Email',
              onPressed: (_) {},
            ),
          ),
        ));

        final themeFinder = find
            .descendant(
              of: find.byKey(Key('arculus-primary-button')),
              matching: find.byType(Theme),
            )
            .first;
        final theme = tester.widget<Theme>(themeFinder);

        expect(
          theme.data.elevatedButtonTheme.style.backgroundColor
              .resolve({MaterialState.disabled}),
          Colors.red.withOpacity(0.5),
        );
      },
    );
  });

  testWidgets(
    'accentColor should be primaryTextTheme.button.color with opacity 0.5',
    (tester) async {
      await tester.pumpWidget(MaterialApp(
        theme: ThemeData(primaryColor: Colors.red),
        home: Scaffold(
          body: ArculusPrimaryButton(
            label: 'Continue with Email',
            onPressed: (_) {},
            isLoading: true,
          ),
        ),
      ));

      final themeFinder = find
          .descendant(
            of: find.byKey(Key('arculus-primary-button')),
            matching: find.byType(Theme),
          )
          .first;
      final theme = tester.widget<Theme>(themeFinder);

      expect(
        theme.data.accentColor,
        theme.data.primaryTextTheme.button.color.withOpacity(0.5),
      );
    },
  );

  group('icon', () {
    testWidgets('by default should use 18 sized email icon', (tester) async {
      await tester.pumpWidget(MaterialApp(
        theme: ThemeData(primaryColor: Colors.red),
        home: Scaffold(
          body: ArculusPrimaryButton(
            label: 'Continue with Email',
            onPressed: (_) {},
            isLoading: false,
          ),
        ),
      ));
      final themeFinder = find
          .descendant(
            of: find.byKey(Key('arculus-primary-button')),
            matching: find.byType(Theme),
          )
          .first;
      final theme = tester.widget<Theme>(themeFinder);

      final icon = find.byKey(Key('arculus-primary-button-default-icon'));
      final iconWidget = tester.widget<Icon>(icon);

      expect(iconWidget.icon, Icons.email);
      expect(iconWidget.size, 18);
      expect(iconWidget.color, theme.data.primaryTextTheme.button.color);
    });

    testWidgets(
      'by default should use 18 sized email icon and '
      '0.5 opacity if isLoading',
      (tester) async {
        await tester.pumpWidget(MaterialApp(
          theme: ThemeData(primaryColor: Colors.red),
          home: Scaffold(
            body: ArculusPrimaryButton(
              label: 'Continue with Email',
              onPressed: (_) {},
              isLoading: true,
            ),
          ),
        ));
        final themeFinder = find
            .descendant(
              of: find.byKey(Key('arculus-primary-button')),
              matching: find.byType(Theme),
            )
            .first;
        final theme = tester.widget<Theme>(themeFinder);

        final icon = find.byKey(Key('arculus-primary-button-default-icon'));
        final iconWidget = tester.widget<Icon>(icon);

        expect(iconWidget.icon, Icons.email);
        expect(iconWidget.size, 18);
        expect(iconWidget.color,
            theme.data.primaryTextTheme.button.color.withOpacity(0.5));
      },
    );

    testWidgets('should use provided icon instead', (tester) async {
      await tester.pumpWidget(MaterialApp(
        theme: ThemeData(primaryColor: Colors.red),
        home: Scaffold(
          body: ArculusPrimaryButton(
            label: 'Continue with Email',
            onPressed: (_) {},
            isLoading: false,
            icon: Container(
              key: Key('dummy-icon'),
              color: Colors.cyan,
            ),
          ),
        ),
      ));

      final icon = find.byKey(Key('arculus-primary-button-default-icon'));
      expect(icon, findsNothing);
      final customIcon = find.byKey(Key('dummy-icon'));
      expect(customIcon, findsOneWidget);
    });
  });
}
