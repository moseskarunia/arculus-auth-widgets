import 'package:arculus_auth_widgets/src/apple_icon.dart';
import 'package:flutter/material.dart';

class ArculusAppleButton extends StatelessWidget {
  final String label;
  final void Function(BuildContext) onPressed;

  const ArculusAppleButton({
    Key key,
    @required this.label,
    this.onPressed,
  }) : super(key: key);

  Color getForegroundColor(
    Set<MaterialState> states,
    Brightness brightness,
  ) {
    Color baseColor =
        brightness == Brightness.dark ? Colors.black : Colors.white;
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.disabled
    };
    if (states.any(interactiveStates.contains)) {
      return baseColor.withOpacity(0.5);
    }
    return baseColor;
  }

  Color getBackgroundColor(
    Set<MaterialState> states,
    Brightness brightness,
  ) {
    Color baseColor =
        brightness == Brightness.dark ? Colors.white : Colors.black;
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.disabled
    };
    if (states.any(interactiveStates.contains)) {
      return baseColor.withOpacity(0.5);
    }
    return baseColor;
  }

  EdgeInsetsGeometry getPadding(Set<MaterialState> states) {
    return EdgeInsets.fromLTRB(16, 16, 16, 16);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: Key('arculus-apple-button'),
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.resolveWith(
          (s) => getForegroundColor(s, Theme.of(context).brightness),
        ),
        backgroundColor: MaterialStateProperty.resolveWith(
          (s) => getBackgroundColor(s, Theme.of(context).brightness),
        ),
        padding: MaterialStateProperty.resolveWith(getPadding),
      ),
      child: Row(
        children: [
          SizedBox(
            child: AppleIcon(),
            width: 18,
            height: 18,
          ),
          SizedBox(width: 32),
          Text(label),
        ],
      ),
      onPressed: onPressed != null ? () => onPressed(context) : null,
    );
  }
}
