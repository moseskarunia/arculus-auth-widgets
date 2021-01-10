import 'package:arculus_auth_widgets/src/google_icon.dart';
import 'package:flutter/material.dart';

/// Google Sign In Button in generic [ElevatedButton.icon()] style.
///
/// You can easily theme it using the ordinary theming of a flutter app.
///
/// If you need to test this widget, the key is
/// `Key('arculus-generic-google-button')`.
///
/// See readme for more info.
class GenericGoogleButton extends StatelessWidget {
  /// Text of the button
  final String label;

  /// If null, the button will be displayed like a "disabled" buttons.
  final void Function(BuildContext) onPressed;

  const GenericGoogleButton({
    Key key,
    @required this.label,
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

  EdgeInsetsGeometry _getDarkPadding(Set<MaterialState> states) {
    return EdgeInsets.fromLTRB(2, 1, 12, 1);
  }

  @override
  Widget build(BuildContext context) {
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

      return ElevatedButton.icon(
        key: Key('arculus-generic-google-button'),
        icon: Container(
          decoration: BoxDecoration(
            borderRadius: _borderRadius,
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(7),
          child: SizedBox(width: 18, height: 18, child: GoogleIcon()),
        ),
        label: Text(label),
        style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                  padding: MaterialStateProperty.resolveWith(_getDarkPadding),
                  foregroundColor: MaterialStateProperty.resolveWith(
                    (s) => _getForegroundColor(s, Theme.of(context).brightness),
                  ),
                  backgroundColor: MaterialStateProperty.resolveWith(
                    (s) => _getBackgroundColor(s, Theme.of(context).brightness),
                  ),
                ) ??
            ButtonStyle(
              padding: MaterialStateProperty.resolveWith(_getDarkPadding),
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

    return ElevatedButton.icon(
      icon: SizedBox(
        width: 18,
        height: 18,
        child: GoogleIcon(),
      ),
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
