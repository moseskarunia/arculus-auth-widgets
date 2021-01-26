import 'package:arculus_auth_widgets/arculus_auth_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockGetForegroundColor extends Mock {
  Color call(Set<MaterialState> states, Brightness brightness);
}

// ignore: must_be_immutable
class MockButtonStyle extends Mock implements ButtonStyle, Diagnosticable {
  // ignore: missing_return
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {}
}

class MockMaterialStateProperty extends Mock
    implements MaterialStateProperty<Color> {}

// ignore: must_be_immutable
class MockTextStyle extends Mock implements TextStyle {
  // ignore: missing_return
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {}
}

void main() {
  MockMaterialStateProperty materialStateProperty;

  setUp(() {
    materialStateProperty = MockMaterialStateProperty();
  });
  testWidgets(
    'root should be an ElevatedButton',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BaseArculusButton(
              label: 'Test Label',
              icon: SizedBox(key: Key('icon')),
            ),
          ),
        ),
      );

      final base = find.byKey(Key('arculus-base-button'));

      expect(base, findsOneWidget);
      expect(tester.widget(base).runtimeType, ElevatedButton);
    },
  );

  testWidgets('should have icon', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BaseArculusButton(
            label: 'Test Label',
            icon: SizedBox(key: Key('icon')),
          ),
        ),
      ),
    );

    final base = find.byKey(Key('arculus-base-button'));

    final childOfButton = find.descendant(
      of: base,
      matching: find.byKey(Key('arculus-base-button-main-child')),
    );

    expect(childOfButton, findsOneWidget);

    final icon = find.descendant(
      of: childOfButton,
      matching: find.byKey(Key('icon')),
    );

    expect(icon, findsOneWidget);
    expect(tester.widget(icon).runtimeType, SizedBox);
  });
  group('button label', () {
    testWidgets(
      'should be visible when !isLoading',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BaseArculusButton(
                label: 'Test Label',
                icon: SizedBox(key: Key('icon')),
              ),
            ),
          ),
        );

        final text = find.descendant(
          of: find.byKey(Key('arculus-base-button-main-child')),
          matching: find.byKey(Key('arculus-base-button-label')),
        );

        expect(text, findsOneWidget);

        final padding = find.ancestor(
          of: text,
          matching: find.byKey(Key('arculus-base-button-label-padding')),
        );
        expect(padding, findsOneWidget);

        expect(
          tester.widget<Padding>(padding).padding,
          const EdgeInsets.only(left: 16),
        );
        expect(
          find.byKey(Key('arculus-base-button-progress-indicator')),
          findsNothing,
        );
      },
    );

    testWidgets(
      'should be invisible when isLoading and '
      'show loading indicator instead',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BaseArculusButton(
                isLoading: true,
                label: 'Test Label',
                icon: SizedBox(key: Key('icon')),
              ),
            ),
          ),
        );

        final text = find.descendant(
          of: find.byKey(Key('arculus-base-button-main-child')),
          matching: find.byKey(Key('arculus-base-button-label')),
        );

        expect(text, findsNothing);

        final progressIndicator = find.descendant(
          of: find.byKey(Key('arculus-base-button-main-child')),
          matching: find.byKey(Key('arculus-base-button-progress-indicator')),
        );

        expect(progressIndicator, findsOneWidget);

        final outerSizedBox = find.ancestor(
          of: progressIndicator,
          matching: find.byKey(Key('arculus-base-button-icon-sized-box')),
        );

        expect(outerSizedBox, findsOneWidget);
        expect(tester.widget<SizedBox>(outerSizedBox).width, 18);
        expect(tester.widget<SizedBox>(outerSizedBox).height, 18);

        final outerCenter = find.ancestor(
          of: outerSizedBox,
          matching: find.byKey(Key('arculus-base-button-icon-center')),
        );

        expect(outerCenter, findsOneWidget);
        expect(tester.widget(outerCenter).runtimeType, Center);

        final outerExpanded = find.ancestor(
          of: outerCenter,
          matching: find.byKey(Key('arculus-base-button-icon-expanded')),
        );

        expect(outerExpanded, findsOneWidget);
        expect(tester.widget(outerExpanded).runtimeType, Expanded);
      },
    );
  });

  group('foregroundColor', () {
    MockGetForegroundColor getForegroundColor;
    MockButtonStyle buttonStyle;

    setUp(() {
      getForegroundColor = MockGetForegroundColor();
      when(getForegroundColor(any, any)).thenReturn(Colors.black);
      buttonStyle = MockButtonStyle();
      when(buttonStyle.foregroundColor).thenReturn(materialStateProperty);
      when(materialStateProperty.resolve(any)).thenReturn(Colors.black);
    });

    group('should call provided getForegroundColor', () {
      BaseArculusButton button;
      setUp(() {
        button = BaseArculusButton(
          label: 'Test Label',
          icon: SizedBox(key: Key('icon')),
          getForegroundColor: getForegroundColor,
          onPressed: (_) {},
        );
      });

      testWidgets(
        'with Brightness.light',
        (tester) async {
          const Set<MaterialState> interactiveStates = <MaterialState>{};

          await tester.pumpWidget(
            MaterialApp(
              themeMode: ThemeMode.light,
              home: Scaffold(body: button),
            ),
          );

          verify(getForegroundColor(interactiveStates, Brightness.light));
        },
      );
      testWidgets(
        'with Brightness.dark',
        (tester) async {
          const Set<MaterialState> interactiveStates = <MaterialState>{};

          await tester.pumpWidget(
            MaterialApp(
              themeMode: ThemeMode.dark,
              darkTheme: ThemeData(brightness: Brightness.dark),
              home: Scaffold(body: button),
            ),
          );

          verify(getForegroundColor(interactiveStates, Brightness.dark));
        },
      );
    });

    testWidgets(
      'should use foregroundColor of root ElevatedButtonTheme.buttonStyle',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            themeMode: ThemeMode.light,
            theme: ThemeData(
              brightness: Brightness.light,
              elevatedButtonTheme: ElevatedButtonThemeData(style: buttonStyle),
            ),
            home: Scaffold(
              body: BaseArculusButton(
                label: 'Test Label',
                icon: SizedBox(key: Key('icon')),
                onPressed: (_) {},
              ),
            ),
          ),
        );

        verifyInOrder([
          buttonStyle.foregroundColor,
          materialStateProperty.resolve(any),
        ]);
      },
    );

    testWidgets('should use primary button text color', (tester) async {
      TextStyle buttonTextStyle = TextStyle(color: Colors.orange);

      await tester.pumpWidget(
        MaterialApp(
          themeMode: ThemeMode.light,
          theme: ThemeData(
            primaryTextTheme: TextTheme(button: buttonTextStyle),
            brightness: Brightness.light,
          ),
          home: Scaffold(
            body: BaseArculusButton(
              label: 'Test Label',
              icon: SizedBox(key: Key('icon')),
              onPressed: (_) {},
            ),
          ),
        ),
      );

      final rootButton = find.byKey(Key('arculus-base-button'));

      expect(
        tester
            .widget<ElevatedButton>(rootButton)
            .style
            .foregroundColor
            .resolve({}),
        Colors.orange,
      );
    });
  });
}
