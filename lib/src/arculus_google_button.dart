import 'package:arculus_auth_widgets/src/base_arculus_button.dart';
import 'package:arculus_auth_widgets/src/google_icon.dart';
import 'package:flutter/material.dart';

/// Google Sign In Button in Arculus Style which I think is neater.
/// If you need the more generic version, see [GenericGoogleButton].
///
/// You can easily theme it using the ordinary theming of a flutter app.
///
/// If you need to test this widget, the key is `Key('arculus-google-button')`.
///
/// See readme for more info.
class ArculusGoogleButton extends StatelessWidget {
  /// Text to display on the button.
  final String label;

  /// If null, the button will be displayed like a "disabled" button.
  final void Function(BuildContext) onPressed;

  /// Displays [CircularProgressIndicator] at the center of the button.
  /// The color of the indicator equals to [Color(0xFF4285F4)] in light, and
  /// [Theme.of(context).primaryTextTheme.button.color] in dark.
  ///
  /// If true, will automatically disables [onPressed].
  final bool isLoading;

  const ArculusGoogleButton({
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
        brightness == Brightness.dark ? Colors.white : Colors.black;
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
        brightness == Brightness.dark ? Color(0xFF4285F4) : Colors.white;
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.disabled
    };
    if (states.any(interactiveStates.contains)) {
      return baseColor.withOpacity(0.5);
    }
    return baseColor;
  }

  EdgeInsetsGeometry _getPadding(
      Set<MaterialState> states, Brightness brightness) {
    if (brightness == Brightness.dark) {
      return EdgeInsets.fromLTRB(0, 0, 16, 0);
    }
    return EdgeInsets.fromLTRB(16, 16, 16, 16);
  }

  @override
  Widget build(BuildContext context) {
    Widget icon = SizedBox(
      width: 18,
      height: 18,
      child: GoogleIcon(),
    );

    if (Theme.of(context).brightness == Brightness.dark) {
      OutlinedBorder _parentBorder = Theme.of(context)
          .elevatedButtonTheme
          ?.style
          ?.shape
          ?.resolve(<MaterialState>{});

      if (_parentBorder == null) {
        _parentBorder = Theme.of(context).buttonTheme?.shape;
      }

      BorderRadiusGeometry _borderRadius = BorderRadius.zero;

      if (_parentBorder is RoundedRectangleBorder) {
        _borderRadius = _parentBorder.borderRadius;
      }

      icon = Container(
        decoration: BoxDecoration(
          borderRadius: _borderRadius,
          color: Colors.white
              .withOpacity(onPressed != null && !isLoading ? 1 : 0.5),
        ),
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.all(14),
        child: SizedBox(
            width: 18,
            height: 18,
            child: GoogleIcon(isEnabled: onPressed != null && !isLoading)),
      );
    }

    return Theme(
      data: Theme.of(context).copyWith(
        accentColor: Theme.of(context).brightness == Brightness.light
            ? Color(0xFF4285F4)
            : Theme.of(context).primaryTextTheme.button.color.withOpacity(0.5),
      ),
      child: BaseArculusButton(
        key: Key('arculus-google-button'),
        isLoading: isLoading,
        child: icon,
        label: label,
        onPressed: onPressed,
        getForegroundColor: _getForegroundColor,
        getBackgroundColor: _getBackgroundColor,
        getPadding: _getPadding,
      ),
    );
  }
}
