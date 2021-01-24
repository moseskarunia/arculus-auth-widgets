import 'package:arculus_auth_widgets/src/base_generic_button.dart';
import 'package:flutter/material.dart';

/// Email Sign In Button in generic [ElevatedButton.icon()] Style.
///
/// You can easily theme it using the ordinary theming of a flutter app.
///
/// If you need to test this widget, the key is
/// `Key('arculus-generic-email-button')`.
///
/// See readme for more info.
class GenericEmailButton extends StatelessWidget {
  /// Text of the button
  final String label;

  /// Email icon. Defaults to [Icons.email]
  final IconData icon;

  /// If null, the button will be displayed like a "disabled" buttons.
  final void Function(BuildContext) onPressed;

  /// Displays [CircularProgressIndicator] at the center of the button.
  /// The color of the indicator equals to
  /// [Theme.of(context).primaryTextTheme.button.color].
  /// If true, will automatically disables [onPressed].
  final bool isLoading;

  const GenericEmailButton({
    Key key,
    @required this.label,
    this.icon = Icons.email,
    this.isLoading = false,
    this.onPressed,
  }) : super(key: key);

  Color _getBackgroundColor(
    Color primaryColor,
    Set<MaterialState> states,
    Brightness brightness,
  ) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.disabled
    };
    if (states.any(interactiveStates.contains)) {
      return primaryColor.withOpacity(0.5);
    }
    return primaryColor;
  }

  @override
  Widget build(BuildContext context) {
    final current =
        Theme.of(context).elevatedButtonTheme?.style?.backgroundColor;

    ElevatedButtonThemeData buttonThemeData =
        Theme.of(context).elevatedButtonTheme;

    if (current == null) {
      if (buttonThemeData == null) {
        buttonThemeData = ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith(
              (s) => _getBackgroundColor(
                Theme.of(context).primaryColor,
                s,
                Theme.of(context).brightness,
              ),
            ),
          ),
        );
      } else {
        buttonThemeData = ElevatedButtonThemeData(
          style: buttonThemeData.style.copyWith(
            backgroundColor: MaterialStateProperty.resolveWith(
              (s) => _getBackgroundColor(
                Theme.of(context).primaryColor,
                s,
                Theme.of(context).brightness,
              ),
            ),
          ),
        );
      }
    }
    return Theme(
      data: Theme.of(context).copyWith(
        elevatedButtonTheme: buttonThemeData,
        accentColor:
            Theme.of(context).primaryTextTheme.button.color.withOpacity(0.5),
      ),
      child: BaseGenericButton(
        key: Key('arculus-generic-email-button'),
        child: Icon(
          icon,
          size: 18,
          color: Theme.of(context)
              .primaryTextTheme
              .button
              .color
              .withOpacity(onPressed != null && !isLoading ? 1 : 0.5),
        ),
        label: label,
        isLoading: isLoading,
        onPressed: onPressed != null && !isLoading ? onPressed : null,
      ),
    );
  }
}
