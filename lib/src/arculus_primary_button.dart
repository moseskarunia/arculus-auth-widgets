import 'package:arculus_auth_widgets/src/base_arculus_button.dart';
import 'package:flutter/material.dart';

/// Primary Sign In button with default icon using email icon with 18 size and
/// color equals to your primaryTextTheme button's color. To override,
/// provide a widget to [icon] property. Make sure that the icon has size 18.
///
/// This button will use the primary color of the closest theme it find,
/// and will apply 0.5 opacity to each icon (only if it's the default email icon, )
///
/// Other than that, it will match the color of your `ElevatedButtonThemeData`.
///
/// If you need to test this widget, the default key is
/// `Key('arculus-primary-button')`.
///
/// See readme for more info.
class ArculusPrimaryButton extends StatelessWidget {
  /// Text to display on the button.
  final String label;

  /// Email icon. Defaults to [Icons.email] with size 18
  final Widget icon;

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

  const ArculusPrimaryButton({
    Key key = const Key('arculus-primary-button'),
    @required this.label,
    this.isLoading = false,
    this.icon,
    this.isExpanded = true,
    this.onPressed,
  }) : super(key: key);

  Color _getBackgroundColor(
    Color primaryColor,
    Set<MaterialState> states,
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
    ElevatedButtonThemeData buttonThemeData =
        Theme.of(context).elevatedButtonTheme;

    if (buttonThemeData?.style == null) {
      buttonThemeData = ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith(
            (s) => _getBackgroundColor(Theme.of(context).primaryColor, s),
          ),
        ),
      );
    } else {
      buttonThemeData = ElevatedButtonThemeData(
        style: buttonThemeData.style.copyWith(
          backgroundColor: MaterialStateProperty.resolveWith(
            (s) => _getBackgroundColor(Theme.of(context).primaryColor, s),
          ),
        ),
      );
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
          child: icon ??
              Icon(
                Icons.email,
                key: Key('arculus-primary-button-default-icon'),
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
