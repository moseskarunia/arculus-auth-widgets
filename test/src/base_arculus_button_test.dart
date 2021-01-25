import 'package:arculus_auth_widgets/arculus_auth_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'should have elevated button as root',
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
}
