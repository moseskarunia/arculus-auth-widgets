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

  const GenericEmailButton({
    Key key,
    @required this.label,
    this.icon = Icons.email,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      key: Key('arculus-generic-email-button'),
      icon: Icon(icon, size: 18),
      label: Text(label),
      onPressed: onPressed != null ? () => onPressed(context) : null,
    );
  }
}
