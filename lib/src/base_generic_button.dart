import 'package:flutter/material.dart';

/// Base button of generic buttons. You can modify it yourself if needed.
class BaseGenericButton extends StatelessWidget {
  /// This is how the [ElevatedButtonTheme] get its foregroundColor.
  final Color Function(Set<MaterialState> states, Brightness brightness)
      getForegroundColor;

  /// This is how the [ElevatedButtonTheme] get its backgroundColor.
  final Color Function(Set<MaterialState> states, Brightness brightness)
      getBackgroundColor;

  /// This is how the [ElevatedButtonTheme] get its padding.
  final EdgeInsetsGeometry Function(
      Set<MaterialState> states, Brightness brightness) getPadding;

  /// Label of the button
  final String label;

  /// Recommended size is an icon with size 18
  final Widget child;

  /// If null, the button will look "disabled". The visual also depends on
  /// [getBackgroundColor], [getBackgroundColor], and [getPadding].
  final void Function(BuildContext) onPressed;

  /// Displays [CircularProgressIndicator] at the center of the button.
  /// The color of the indicator equals to [Theme.of(context).accentColor].
  ///
  /// If true, will automatically disables [onPressed].
  final bool isLoading;

  const BaseGenericButton({
    Key key,
    @required this.label,
    @required this.child,
    this.isLoading = false,
    this.getForegroundColor,
    this.getBackgroundColor,
    this.getPadding,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MaterialStateProperty<Color> foregroundColor = getForegroundColor != null
        ? MaterialStateProperty.resolveWith(
            (s) => getForegroundColor(s, Theme.of(context).brightness),
          )
        : Theme.of(context).elevatedButtonTheme.style?.foregroundColor;

    MaterialStateProperty<Color> backgroundColor = getBackgroundColor != null
        ? MaterialStateProperty.resolveWith(
            (s) => getBackgroundColor(s, Theme.of(context).brightness),
          )
        : Theme.of(context).elevatedButtonTheme.style?.backgroundColor;

    MaterialStateProperty<EdgeInsetsGeometry> padding = getPadding != null
        ? MaterialStateProperty.resolveWith(
            (s) => getPadding(s, Theme.of(context).brightness),
          )
        : Theme.of(context).elevatedButtonTheme.style?.padding;

    return ElevatedButton.icon(
      key: Key('arculus-generic-base-button'),
      icon: child,
      label: isLoading
          ? Center(
              child: SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          : Text(label),
      style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                foregroundColor: foregroundColor,
                backgroundColor: backgroundColor,
                padding: padding,
              ) ??
          ButtonStyle(
            foregroundColor: foregroundColor,
            backgroundColor: backgroundColor,
            padding: padding,
          ),
      onPressed:
          onPressed != null && !isLoading ? () => onPressed(context) : null,
    );
  }
}
