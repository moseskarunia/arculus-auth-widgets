import 'package:arculus_auth_widgets/src/apple_icon.dart';
import 'package:flutter/material.dart';

/// Apple Sign In Button in generic [ElevatedButton.icon()] Style.
///
/// You can easily theme it using the ordinary theming of a flutter app.
///
/// If you need to test this widget, the key is
/// `Key('arculus-generic-apple-button')`.
///
/// See readme for more info.
class GenericAppleButton extends StatelessWidget {
  /// Text of the button
  final String label;

  /// If null, the button will be displayed like a "disabled" buttons.
  final void Function(BuildContext) onPressed;

  const GenericAppleButton({
    Key key,
    @required this.label,
    this.onPressed,
  }) : super(key: key);

  Color _getForegroundColor(
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

  Color _getBackgroundColor(
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

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      key: Key('arculus-generic-apple-button'),
      icon: SizedBox(child: AppleIcon(), width: 18, height: 18),
      label: Text(label),
      style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                foregroundColor: MaterialStateProperty.resolveWith(
                  (s) => _getForegroundColor(s, Theme.of(context).brightness),
                ),
                backgroundColor: MaterialStateProperty.resolveWith(
                  (s) => _getBackgroundColor(s, Theme.of(context).brightness),
                ),
              ) ??
          ButtonStyle(
            foregroundColor: MaterialStateProperty.resolveWith(
              (s) => _getForegroundColor(s, Theme.of(context).brightness),
            ),
            backgroundColor: MaterialStateProperty.resolveWith(
              (s) => _getBackgroundColor(s, Theme.of(context).brightness),
            ),
          ),
      onPressed: onPressed != null ? () => onPressed(context) : null,
    );
  }
}
