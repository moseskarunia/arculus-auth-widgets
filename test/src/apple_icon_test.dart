import 'package:arculus_auth_widgets/arculus_auth_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('should use white icon when Brightness is light', (tester) async {
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
    expect(blackIcon, findsNothing);
  });

  testWidgets('should use black icon when Brightness is dark', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData(brightness: Brightness.dark),
        home: Scaffold(body: AppleIcon()),
      ),
    );

    final whiteIcon = find.byKey(Key('apple-icon-white'));
    final blackIcon = find.byKey(Key('apple-icon-black'));

    expect(blackIcon, findsOneWidget);
    expect(tester.widget(blackIcon).runtimeType, Image);
    expect(whiteIcon, findsNothing);
  });
}
