import 'package:arculus_auth_widgets/src/base_arculus_button.dart';
import 'package:arculus_auth_widgets/src/google_icon.dart';
import 'package:flutter/material.dart';

/// Google Sign In Button
///
/// You can easily theme it using the ordinary theming of a flutter app.
///
/// If you need to test this widget, the default key is
/// `Key('arculus-google-button')`.
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

  /// If true, the button will fill the full available width. The icon still
  /// placed at the left-most side. Default is true.
  final bool isExpanded;

  const ArculusGoogleButton({
    Key key = const Key('arculus-google-button'),
    @required this.label,
    this.isLoading = false,
    this.isExpanded = true,
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

  @override
  Widget build(BuildContext context) {
    Widget icon = SizedBox(
      width: 18,
      height: 18,
      child: GoogleIcon(isEnabled: onPressed != null && !isLoading),
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
        key: Key('google-icon-background'),
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
    } else {
      icon = Padding(
        padding: const EdgeInsets.all(16),
        child: icon,
      );
    }

    return Theme(
      data: Theme.of(context).copyWith(
        accentColor: Theme.of(context).brightness == Brightness.light
            ? Color(0xFF4285F4).withOpacity(0.5)
            : Theme.of(context).primaryTextTheme.button.color.withOpacity(0.5),
      ),
      child: BaseArculusButton(
        isExpanded: isExpanded,
        isLoading: isLoading,
        icon: icon,
        label: label,
        onPressed: onPressed,
        getForegroundColor: _getForegroundColor,
        getBackgroundColor: _getBackgroundColor,
        getPadding: (s, _) => EdgeInsets.fromLTRB(0, 0, 16, 0),
      ),
    );
  }
}
