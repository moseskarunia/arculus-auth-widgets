import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Plain Apple Icon. If your app brightness is light, will use
/// the white-colored apple icon. Otherwise black.
///
/// If you want ot size it, wrap it in a SizedBox
///
/// ```dart
/// SizedBox(
///   width: 18,
///   height: 18,
///   child: AppleIcon(),
/// )
/// ```
///
/// If you want to override the global theme brightness, wrap it in a copied
/// theme.
///
/// ```dart
/// Theme(
///   data: Theme.of(context).copyWith(brightness: Brightness.dark),
///   child: AppleIcon(),
/// ),
/// ```
class AppleIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? SvgPicture.asset(
            'assets/apple_white.svg',
            key: Key('apple-icon-white'),
            package: 'arculus_auth_widgets',
          )
        : SvgPicture.asset(
            'assets/apple_black.svg',
            key: Key('apple-icon-black'),
            package: 'arculus_auth_widgets',
          );
  }
}
