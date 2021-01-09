import 'package:arculus_auth_widgets/src/apple_icon.dart';
import 'package:flutter/material.dart';

/// Apple Sign In Button in Arculus Style which I think is neater.
/// If you need the more generic version, see [GenericAppleButton].
///
/// You can easily theme it using the ordinary theming of a flutter app.
///
/// If you need to test this widget, the key is `Key('arculus-apple-button')`.
///
/// See readme for more info.
class ArculusAppleButton extends StatelessWidget {
  /// Text to display on the button.
  final String label;

  /// If null, the button will be displayed like a "disabled" buttons.
  final void Function(BuildContext) onPressed;

  const ArculusAppleButton({
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

  EdgeInsetsGeometry _getPadding(Set<MaterialState> states) {
    return EdgeInsets.fromLTRB(16, 16, 16, 16);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: Key('arculus-apple-button'),
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.resolveWith(
          (s) => _getForegroundColor(s, Theme.of(context).brightness),
        ),
        backgroundColor: MaterialStateProperty.resolveWith(
          (s) => _getBackgroundColor(s, Theme.of(context).brightness),
        ),
        padding: MaterialStateProperty.resolveWith(_getPadding),
      ),
      child: Row(
        children: [
          SizedBox(child: AppleIcon(), width: 18, height: 18),
          SizedBox(width: 32),
          Text(label),
        ],
      ),
      onPressed: onPressed != null ? () => onPressed(context) : null,
    );
  }
}
