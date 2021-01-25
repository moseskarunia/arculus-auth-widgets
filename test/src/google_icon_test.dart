import 'package:arculus_auth_widgets/arculus_auth_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'Opacity should be 1 when isEnabled',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: GoogleIcon()),
        ),
      );

      final googleIcon = find.byKey(Key('google-icon-image'));

      expect(googleIcon, findsOneWidget);
      expect(
        tester
            .widget<Opacity>(
              find.ancestor(of: googleIcon, matching: find.byType(Opacity)),
            )
            .opacity,
        1,
      );
    },
  );
  testWidgets(
    'Opacity should be 0.5 when !isEnabled',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: GoogleIcon(isEnabled: false)),
        ),
      );

      final googleIcon = find.byKey(Key('google-icon-image'));

      expect(googleIcon, findsOneWidget);
      expect(
        tester
            .widget<Opacity>(
              find.ancestor(of: googleIcon, matching: find.byType(Opacity)),
            )
            .opacity,
        0.5,
      );
    },
  );
}
