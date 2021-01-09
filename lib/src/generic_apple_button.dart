import 'package:arculus_auth_widgets/src/apple_icon.dart';
import 'package:flutter/material.dart';

class GenericAppleButton extends StatelessWidget {
  final String label;
  final void Function(BuildContext) onPressed;

  const GenericAppleButton({
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
    return ElevatedButton.icon(
      key: Key('arculus-generic-apple-button'),
      icon: AppleIcon(),
      label: Text(label),
      style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                foregroundColor: MaterialStateProperty.resolveWith(
                  (s) => getForegroundColor(s, Theme.of(context).brightness),
                ),
                backgroundColor: MaterialStateProperty.resolveWith(
                  (s) => getBackgroundColor(s, Theme.of(context).brightness),
                ),
              ) ??
          ButtonStyle(
            foregroundColor: MaterialStateProperty.resolveWith(
              (s) => getForegroundColor(s, Theme.of(context).brightness),
            ),
            backgroundColor: MaterialStateProperty.resolveWith(
              (s) => getBackgroundColor(s, Theme.of(context).brightness),
            ),
          ),
      onPressed: onPressed != null ? () => onPressed(context) : null,
    );
  }
}
