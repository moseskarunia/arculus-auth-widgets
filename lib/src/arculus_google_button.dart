import 'package:arculus_auth_widgets/src/google_icon.dart';
import 'package:flutter/material.dart';

class ArculusGoogleButton extends StatelessWidget {
  final String label;
  final void Function(BuildContext) onPressed;

  const ArculusGoogleButton({
    Key key,
    @required this.label,
    this.onPressed,
  }) : super(key: key);

  Color getForegroundColor(
    Set<MaterialState> states,
    Brightness brightness,
  ) {
    Color baseColor =
        brightness == Brightness.dark ? Colors.white : Colors.black;
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.disabled
    };
    if (states.any(interactiveStates.contains)) {
      return baseColor.withOpacity(0.5);
    }
    return baseColor;
  }

  Color getBackgroundColor(
    Set<MaterialState> states,
    Brightness brightness,
  ) {
    Color baseColor =
        brightness == Brightness.dark ? Color(0xFF4285F4) : Colors.white;
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.disabled
    };
    if (states.any(interactiveStates.contains)) {
      return baseColor.withOpacity(0.5);
    }
    return baseColor;
  }

  EdgeInsetsGeometry getDarkPadding(
    Set<MaterialState> states, [
    bool useArculusStyle = false,
  ]) {
    return EdgeInsets.fromLTRB(2, 2, 16, 2);
  }

  EdgeInsetsGeometry getPadding(Set<MaterialState> states) {
    return EdgeInsets.fromLTRB(16, 16, 16, 16);
  }

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).brightness == Brightness.dark) {
      BorderRadius _parentRadius = (Theme.of(context)
                  .elevatedButtonTheme
                  ?.style
                  ?.shape
                  ?.resolve(<MaterialState>{}) as RoundedRectangleBorder)
              ?.borderRadius ??
          BorderRadius.circular(4);

      return ElevatedButton(
        key: Key('arculus-google-button'),
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.resolveWith(
            (s) => getForegroundColor(s, Theme.of(context).brightness),
          ),
          backgroundColor: MaterialStateProperty.resolveWith(
            (s) => getBackgroundColor(s, Theme.of(context).brightness),
          ),
          padding: MaterialStateProperty.resolveWith(getDarkPadding),
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: _parentRadius,
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(14),
              child: SizedBox(
                width: 18,
                height: 18,
                child: GoogleIcon(),
              ),
            ),
            SizedBox(width: 16),
            Text(label),
          ],
        ),
        onPressed: onPressed != null ? () => onPressed(context) : null,
      );
    }

    return ElevatedButton(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.resolveWith(
          (s) => getForegroundColor(s, Theme.of(context).brightness),
        ),
        backgroundColor: MaterialStateProperty.resolveWith(
          (s) => getBackgroundColor(s, Theme.of(context).brightness),
        ),
        padding: MaterialStateProperty.resolveWith(getPadding),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 18,
            height: 18,
            child: GoogleIcon(),
          ),
          SizedBox(width: 32),
          Text(label),
        ],
      ),
      onPressed: onPressed != null ? () => onPressed(context) : null,
    );
  }
}
