import 'package:flutter/material.dart';

/// Email Sign In Button in Arculus Style which I think is neater.
/// If you need the more generic version, see [GenericEmailButton].
///
/// You can easily theme it using the ordinary theming of a flutter app.
///
/// If you need to test this widget, the key is `Key('arculus-email-button')`.
///
/// See readme for more info.
class ArculusEmailButton extends StatelessWidget {
  /// Text to show on the label.
  final String label;

  /// Email icon. Defaults to [Icons.email]
  final IconData icon;

  /// If null, the button will be displayed like a "disabled" buttons.
  final void Function(BuildContext) onPressed;

  const ArculusEmailButton({
    Key key,
    @required this.label,
    this.icon = Icons.email,
    this.onPressed,
  }) : super(key: key);

  EdgeInsetsGeometry _getPadding(Set<MaterialState> states) {
    return EdgeInsets.fromLTRB(16, 16, 16, 16);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: Key('arculus-email-button'),
      style: ButtonStyle(
        padding: MaterialStateProperty.resolveWith(_getPadding),
      ),
      child: Row(
        children: [
          Icon(Icons.email, size: 18),
          SizedBox(width: 32),
          Text(label),
        ],
      ),
      onPressed: onPressed != null ? () => onPressed(context) : null,
    );
  }
}
