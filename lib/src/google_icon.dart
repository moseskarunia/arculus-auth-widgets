import 'package:flutter/material.dart';

/// Plain Apple Icon. If your app brightness is light, will use
/// the white-colored apple icon. Otherwise black.
///
/// If you want ot size it, wrap it in a SizedBox
///
/// ```dart
/// SizedBox(
///   width: 18,
///   height: 18,
///   child: GoogleIcon(),
/// )
/// ```
///
/// Unlike `AppleIcon`, `GoogleIcon` stays the same regardless of theme
/// brightness. If you want to add white color to the background, do:
///
/// ```dart
///Container(
///  decoration: BoxDecoration(
///    borderRadius: BorderRadius.circular(4),
///    color: Colors.white,
///  ),
///  padding: const EdgeInsets.all(8),
///  child: SizedBox(
///    width: 18,
///    height: 18,
///    child: GoogleIcon(),
///  ),
///);
/// ```
class GoogleIcon extends StatelessWidget {
  final bool isEnabled;

  const GoogleIcon({
    Key key = const Key('google-icon'),
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isEnabled ? 1 : 0.5,
      child: Image.asset(
        'assets/google.png',
        key: Key('google-icon-image'),
        package: 'arculus_auth_widgets',
      ),
    );
  }
}
