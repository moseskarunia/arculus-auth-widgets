import 'package:arculus_auth_widgets/src/apple_icon.dart';
import 'package:arculus_auth_widgets/src/base_generic_button.dart';
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

  /// Displays [CircularProgressIndicator] at the center of the button.
  /// The color of the indicator equals to [Colors.white] in light, and
  /// [Colors.black] in dark.
  ///
  /// If true, will automatically disables [onPressed].
  final bool isLoading;

  const GenericAppleButton({
    Key key,
    @required this.label,
    this.onPressed,
    this.isLoading = false,
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
    return Theme(
      data: Theme.of(context).copyWith(
        accentColor: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : Colors.black,
      ),
      child: BaseGenericButton(
        key: Key('arculus-generic-apple-button'),
        child: SizedBox(child: AppleIcon(), width: 18, height: 18),
        label: label,
        getForegroundColor: _getForegroundColor,
        getBackgroundColor: _getBackgroundColor,
        isLoading: isLoading,
        onPressed: onPressed != null && !isLoading ? onPressed : null,
      ),
    );
  }
}
