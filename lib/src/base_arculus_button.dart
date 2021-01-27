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
  final Widget icon;

  /// If null, the button will look "disabled". The visual also depends on
  /// [getBackgroundColor], [getBackgroundColor], and [getPadding].
  final void Function(BuildContext) onPressed;

  /// Displays [CircularProgressIndicator] at the center of the button.
  /// The color of the indicator equals to [Theme.of(context).accentColor].
  ///
  /// If true, will automatically disables [onPressed].
  final bool isLoading;

  /// If true, the button will fill the full available width. The icon still
  /// placed at the left-most side. Default is true.
  final bool isExpanded;

  const BaseArculusButton({
    Key key,
    @required this.label,
    @required this.icon,
    this.onPressed,
    this.getForegroundColor,
    this.getBackgroundColor,
    this.getPadding,
    this.isLoading = false,
    this.isExpanded = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> buttonChildren = [
      icon,
      Padding(
        key: Key('arculus-base-button-label-padding'),
        padding: const EdgeInsets.only(left: 16),
        child: Text(
          label,
          key: Key('arculus-base-button-label'),
        ),
      )
    ];

    if (isExpanded) {
      buttonChildren.add(Spacer(
        key: Key('arculus-base-button-spacer'),
      ));
    }

    if (isLoading) {
      buttonChildren.add(Padding(
        padding: const EdgeInsets.only(left: 16),
        child: SizedBox(
          key: Key('arculus-base-button-progress-indicator-sized-box'),
          width: 12,
          height: 12,
          child: CircularProgressIndicator(
            key: Key('arculus-base-button-progress-indicator'),
            strokeWidth: 2,
          ),
        ),
      ));
    }

    return ElevatedButton(
      key: Key('arculus-base-button'),
      style: ButtonStyle(
        foregroundColor: (getForegroundColor != null
                ? MaterialStateProperty.resolveWith(
                    (s) => getForegroundColor(s, Theme.of(context).brightness),
                  )
                : Theme.of(context)
                    .elevatedButtonTheme
                    ?.style
                    ?.foregroundColor) ??
            MaterialStateProperty.resolveWith(
              (s) => Theme.of(context).primaryTextTheme.button.color,
            ),
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
      child: Row(
        key: Key('arculus-base-button-main-child'),
        mainAxisSize: isExpanded ? MainAxisSize.max : MainAxisSize.min,
        children: buttonChildren,
      ),
      onPressed:
          onPressed != null && !isLoading ? () => onPressed(context) : null,
    );
  }
}
