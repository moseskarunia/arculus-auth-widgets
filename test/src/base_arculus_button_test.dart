import 'package:arculus_auth_widgets/arculus_auth_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockOnPressed extends Mock {
  void call(BuildContext context);
}

class MockGetForegroundColor extends Mock {
  Color call(Set<MaterialState> states, Brightness brightness);
}

class MockGetBackgroundColor extends Mock {
  Color call(Set<MaterialState> states, Brightness brightness);
}

class MockGetPadding extends Mock {
  EdgeInsetsGeometry call(Set<MaterialState> states, Brightness brightness);
}

// ignore: must_be_immutable
class MockButtonStyle extends Mock implements ButtonStyle, Diagnosticable {
  // ignore: missing_return
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {}
}

class MockMaterialStateProperty<T> extends Mock
    implements MaterialStateProperty<T> {}

// ignore: must_be_immutable
class MockTextStyle extends Mock implements TextStyle {
  // ignore: missing_return
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {}
}

void main() {
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

  testWidgets(
    'button label should be visible',
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
    'loading indicator should be visible when isLoading',
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

      final progressIndicator = find.descendant(
        of: find.byKey(Key('arculus-base-button-main-child')),
        matching: find.byKey(Key('arculus-base-button-progress-indicator')),
      );

      expect(progressIndicator, findsOneWidget);

      final outerSizedBox = find.ancestor(
        of: progressIndicator,
        matching:
            find.byKey(Key('arculus-base-button-progress-indicator-sized-box')),
      );

      expect(outerSizedBox, findsOneWidget);
      expect(tester.widget<SizedBox>(outerSizedBox).width, 12);
      expect(tester.widget<SizedBox>(outerSizedBox).height, 12);
    },
  );

  testWidgets('should find Spacer if isExpanded', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BaseArculusButton(
            label: 'Test Label',
            icon: SizedBox(key: Key('icon')),
            isExpanded: true,
          ),
        ),
      ),
    );

    final spacer = find.byKey(Key('arculus-base-button-spacer'));

    expect(spacer, findsOneWidget);
    expect(tester.widget(spacer).runtimeType, Spacer);
  });

  group('foregroundColor', () {
    MockMaterialStateProperty<Color> materialStateProperty;
    MockGetForegroundColor getForegroundColor;
    MockButtonStyle buttonStyle;

    setUp(() {
      materialStateProperty = MockMaterialStateProperty<Color>();
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

  group('backgroundColor', () {
    MockMaterialStateProperty<Color> materialStateProperty;
    MockGetBackgroundColor getBackgroundColor;
    MockButtonStyle buttonStyle;

    setUp(() {
      materialStateProperty = MockMaterialStateProperty<Color>();
      getBackgroundColor = MockGetBackgroundColor();
      when(getBackgroundColor(any, any)).thenReturn(Colors.black);
      buttonStyle = MockButtonStyle();
      when(buttonStyle.backgroundColor).thenReturn(materialStateProperty);
      when(materialStateProperty.resolve(any)).thenReturn(Colors.black);
    });

    group('should call provided getBackgroundColor', () {
      BaseArculusButton button;
      setUp(() {
        button = BaseArculusButton(
          label: 'Test Label',
          icon: SizedBox(key: Key('icon')),
          getBackgroundColor: getBackgroundColor,
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

          verify(getBackgroundColor(interactiveStates, Brightness.light));
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

          verify(getBackgroundColor(interactiveStates, Brightness.dark));
        },
      );
    });

    testWidgets(
      'should use background of root ElevatedButtonTheme.buttonStyle',
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
          buttonStyle.backgroundColor,
          materialStateProperty.resolve(any),
        ]);
      },
    );

    testWidgets('should use primary color scheme', (tester) async {
      TextStyle buttonTextStyle = TextStyle(color: Colors.orange);

      await tester.pumpWidget(
        MaterialApp(
          themeMode: ThemeMode.light,
          theme: ThemeData(
            buttonTheme: ButtonThemeData(
                colorScheme: ColorScheme.light(primary: Colors.amber)),
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
            .backgroundColor
            .resolve({}),
        Colors.amber,
      );
    });
  });

  group('padding', () {
    MockMaterialStateProperty<EdgeInsetsGeometry> materialStateProperty;
    MockGetPadding getPadding;
    MockButtonStyle buttonStyle;

    setUp(() {
      materialStateProperty = MockMaterialStateProperty();
      getPadding = MockGetPadding();
      when(getPadding(any, any)).thenReturn(EdgeInsets.all(16));
      buttonStyle = MockButtonStyle();
      when(buttonStyle.padding).thenReturn(materialStateProperty);
      when(materialStateProperty.resolve(any)).thenReturn(EdgeInsets.all(16));
    });

    group('should call provided getBackgroundColor', () {
      BaseArculusButton button;
      setUp(() {
        button = BaseArculusButton(
          label: 'Test Label',
          icon: SizedBox(key: Key('icon')),
          getPadding: getPadding,
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

          verify(getPadding(interactiveStates, Brightness.light));
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

          verify(getPadding(interactiveStates, Brightness.dark));
        },
      );
    });

    testWidgets(
      'should use padding of root ElevatedButtonTheme.buttonStyle',
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
          buttonStyle.backgroundColor,
          materialStateProperty.resolve(any),
        ]);
      },
    );

    testWidgets('should use primary button padding', (tester) async {
      final buttonTheme = ButtonThemeData(
        colorScheme: ColorScheme.light(primary: Colors.amber),
        padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
      );

      await tester.pumpWidget(
        MaterialApp(
          themeMode: ThemeMode.light,
          theme: ThemeData(
            buttonTheme: buttonTheme,
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
        tester.widget<ElevatedButton>(rootButton).style.padding.resolve({}),
        EdgeInsets.fromLTRB(16, 8, 16, 8),
      );
    });
  });

  group('when button pressed', () {
    MockOnPressed onPressed;

    setUp(() {
      onPressed = MockOnPressed();
    });
    testWidgets('onPressed should be called', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BaseArculusButton(
              label: 'Test Label',
              icon: SizedBox(key: Key('icon')),
              onPressed: onPressed,
            ),
          ),
        ),
      );

      final button = find.byKey(Key('arculus-base-button'));

      expect(button, findsOneWidget);
      await tester.tap(button);

      verify(onPressed(any));
    });
    testWidgets(
      'onPressed should NOT be called when isLoading',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BaseArculusButton(
                isLoading: true,
                label: 'Test Label',
                icon: SizedBox(key: Key('icon')),
                onPressed: onPressed,
              ),
            ),
          ),
        );

        final button = find.byKey(Key('arculus-base-button'));

        tester.press(button);

        verifyNever(onPressed(any));
      },
    );
  });
}
