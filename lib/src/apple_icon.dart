import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
