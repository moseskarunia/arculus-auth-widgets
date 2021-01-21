import 'package:arculus_auth_widgets/src/apple_icon.dart';
import 'package:arculus_auth_widgets/src/base_arculus_button.dart';
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

  /// If null, the button will be displayed like a "disabled" button.
  final void Function(BuildContext) onPressed;

  /// Displays [CircularProgressIndicator] at the center of the button.
  /// The color of the indicator equals to [Colors.white] in light, and
  /// [Colors.black] in dark.
  ///
  /// If true, will automatically disables [onPressed].
  final bool isLoading;

  const ArculusAppleButton({
    Key key,
    @required this.label,
    this.isLoading = false,
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

  EdgeInsetsGeometry _getPadding(
    Set<MaterialState> states,
    Brightness brightness,
  ) {
    return EdgeInsets.fromLTRB(16, 16, 16, 16);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        accentColor: Theme.of(context).brightness == Brightness.light
            ? Colors.white.withOpacity(0.5)
            : Colors.black.withOpacity(0.5),
      ),
      child: BaseArculusButton(
        key: Key('arculus-apple-button'),
        isLoading: isLoading,
        child: Container(
          margin: const EdgeInsets.only(right: 16),
          child: AppleIcon(
            isEnabled: onPressed != null && !isLoading,
          ),
          width: 18,
          height: 18,
        ),
        label: label,
        onPressed: onPressed,
        getForegroundColor: _getForegroundColor,
        getBackgroundColor: _getBackgroundColor,
        getPadding: _getPadding,
      ),
    );
  }
}
