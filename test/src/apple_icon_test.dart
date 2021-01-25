import 'package:arculus_auth_widgets/arculus_auth_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'should use white icon when Brightness is light '
    'with opacity 1 when isEnabled',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          themeMode: ThemeMode.light,
          home: Scaffold(body: AppleIcon()),
        ),
      );

      final whiteIcon = find.byKey(Key('apple-icon-white'));
      final blackIcon = find.byKey(Key('apple-icon-black'));

      expect(whiteIcon, findsOneWidget);
      expect(tester.widget(whiteIcon).runtimeType, Image);
      expect(
        tester
            .widget<Opacity>(
              find.ancestor(of: whiteIcon, matching: find.byType(Opacity)),
            )
            .opacity,
        1,
      );
      expect(blackIcon, findsNothing);
    },
  );

  testWidgets(
    'should use black icon when Brightness is dark '
    'with opacity 0.5 when !isEnabled',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          themeMode: ThemeMode.dark,
          darkTheme: ThemeData(brightness: Brightness.dark),
          home: Scaffold(body: AppleIcon(isEnabled: false)),
        ),
      );

      final whiteIcon = find.byKey(Key('apple-icon-white'));
      final blackIcon = find.byKey(Key('apple-icon-black'));

      expect(blackIcon, findsOneWidget);
      expect(tester.widget(blackIcon).runtimeType, Image);
      expect(
        tester
            .widget<Opacity>(
              find.ancestor(of: blackIcon, matching: find.byType(Opacity)),
            )
            .opacity,
        0.5,
      );
      expect(whiteIcon, findsNothing);
    },
  );
}
