import 'package:arculus_auth_widgets/src/base_arculus_button.dart';
import 'package:flutter/material.dart';

/// Email Sign In Button.
///
/// You can easily theme it using the ordinary theming of a flutter app.
///
/// If you need to test this widget, the default key is
/// `Key('arculus-email-button')`.
///
/// See readme for more info.
class ArculusEmailButton extends StatelessWidget {
  /// Text to display on the button.
  final String label;

  /// Email icon. Defaults to [Icons.email]
  final IconData icon;

  /// If null, the button will be displayed like a "disabled" button.
  final void Function(BuildContext) onPressed;

  /// Displays [CircularProgressIndicator] at the center of the button.
  /// The color of the indicator equals to
  /// [Theme.of(context).primaryTextTheme.button.color].
  /// If true, will automatically disables [onPressed].
  final bool isLoading;

  /// If true, the button will fill the full available width. The icon still
  /// placed at the left-most side. Default is true.
  final bool isExpanded;

  const ArculusEmailButton({
    Key key = const Key('arculus-email-button'),
    @required this.label,
    this.isLoading = false,
    this.icon = Icons.email,
    this.isExpanded = true,
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
      if (buttonThemeData?.style == null) {
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
      child: BaseArculusButton(
        isExpanded: isExpanded,
        isLoading: isLoading,
        icon: Padding(
          padding: const EdgeInsets.all(16),
          child: Icon(
            Icons.email,
            size: 18,
            color: Theme.of(context)
                .primaryTextTheme
                .button
                .color
                .withOpacity(onPressed != null && !isLoading ? 1 : 0.5),
          ),
        ),
        label: label,
        onPressed: onPressed,
        getPadding: (s, _) => EdgeInsets.fromLTRB(0, 0, 16, 0),
      ),
    );
  }
}
