import 'package:flutter/material.dart';

/// Base button of arculus buttons. You can modify it yourself if needed.
class BaseArculusButton extends StatelessWidget {
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

  /// Icon to label spacing
  final double iconToLabelHorizontalSpacing;

  /// Displays [CircularProgressIndicator] at the center of the button.
  /// The color of the indicator equals to [Theme.of(context).accentColor].
  ///
  /// If true, will automatically disables [onPressed].
  final bool isLoading;

  const BaseArculusButton({
    Key key,
    @required this.label,
    @required this.child,
    this.onPressed,
    this.getForegroundColor,
    this.getBackgroundColor,
    this.getPadding,
    this.iconToLabelHorizontalSpacing = 32,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: key,
      style: ButtonStyle(
        foregroundColor: (getForegroundColor != null
                ? MaterialStateProperty.resolveWith(
                    (s) => getForegroundColor(s, Theme.of(context).brightness),
                  )
                : Theme.of(context)
                    .elevatedButtonTheme
                    .style
                    .foregroundColor) ??
            MaterialStateProperty.resolveWith(
                (s) => Theme.of(context).primaryTextTheme.button.color),
        backgroundColor: (getBackgroundColor != null
                ? MaterialStateProperty.resolveWith(
                    (s) => getBackgroundColor(s, Theme.of(context).brightness),
                  )
                : Theme.of(context)
                    .elevatedButtonTheme
                    ?.style
                    ?.backgroundColor) ??
            MaterialStateProperty.resolveWith(
                (s) => Theme.of(context).buttonTheme.colorScheme.primary),
        padding: (getPadding != null
                ? MaterialStateProperty.resolveWith(
                    (s) => getPadding(s, Theme.of(context).brightness),
                  )
                : Theme.of(context).elevatedButtonTheme?.style?.padding) ??
            MaterialStateProperty.resolveWith(
                (s) => Theme.of(context).buttonTheme.padding),
      ),
      child: Row(children: [
        child,
        isLoading
            ? Expanded(
                child: Center(
                  child: SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              )
            : Padding(
                padding: EdgeInsets.only(
                  left: iconToLabelHorizontalSpacing,
                ),
                child: Text(label),
              )
      ]),
      onPressed:
          onPressed != null && !isLoading ? () => onPressed(context) : null,
    );
  }
}
