import 'package:flutter/material.dart';

/// ElevatedButton with email icon and text.
class ArculusEmailButton extends StatelessWidget {
  final String label;
  final void Function(BuildContext) onPressed;

  const ArculusEmailButton({
    Key key,
    @required this.label,
    this.onPressed,
  }) : super(key: key);

  EdgeInsetsGeometry getPadding(Set<MaterialState> states) {
    return EdgeInsets.fromLTRB(16, 16, 16, 16);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: Key('arculus-email-button'),
      style: ButtonStyle(
        padding: MaterialStateProperty.resolveWith(getPadding),
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
