import 'package:flutter/material.dart';

/// ElevatedButton with email icon and text.
class GenericEmailButton extends StatelessWidget {
  final String label;
  final void Function(BuildContext) onPressed;

  const GenericEmailButton({
    Key key,
    @required this.label,
    this.onPressed,
  }) : super(key: key);

  EdgeInsetsGeometry getPadding(Set<MaterialState> states) {
    return EdgeInsets.fromLTRB(16, 16, 16, 16);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      key: Key('arculus-generic-email-button'),
      icon: Icon(Icons.email),
      label: Text(label),
      onPressed: onPressed != null ? () => onPressed(context) : null,
    );
  }
}
