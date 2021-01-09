import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GoogleIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/google.svg',
      key: Key('google-icon'),
      package: 'arculus_auth_widgets',
    );
  }
}
