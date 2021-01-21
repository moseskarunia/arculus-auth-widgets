import 'package:arculus_auth_widgets/src/base_arculus_button.dart';
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
  /// Text to display on the button.
  final String label;

  /// Email icon. Defaults to [Icons.email]
  final IconData icon;

  /// If null, the button will be displayed like a "disabled" button.
  final void Function(BuildContext) onPressed;

  const ArculusEmailButton({
    Key key,
    @required this.label,
    this.icon = Icons.email,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseArculusButton(
      key: Key('arculus-email-button'),
      child: Icon(Icons.email, size: 18),
      label: label,
      onPressed: onPressed != null ? onPressed : null,
      getPadding: (s, _) => EdgeInsets.all(16),
    );
  }
}
