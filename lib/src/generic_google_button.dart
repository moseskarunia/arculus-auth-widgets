import 'package:arculus_auth_widgets/src/google_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GenericGoogleButton extends StatelessWidget {
  final String label;
  final void Function(BuildContext) onPressed;

  const GenericGoogleButton({
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

  EdgeInsetsGeometry getDarkPadding(Set<MaterialState> states) {
    return EdgeInsets.fromLTRB(2, 1, 12, 1);
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
      return ElevatedButton.icon(
        key: Key('arculus-generic-google-button'),
        icon: Container(
          decoration: BoxDecoration(
            borderRadius: _parentRadius,
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(7),
          child: SvgPicture.asset(
            'assets/google.svg',
            package: 'arculus_auth_widgets',
          ),
        ),
        label: Text(label),
        style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                  padding: MaterialStateProperty.resolveWith(getDarkPadding),
                  foregroundColor: MaterialStateProperty.resolveWith(
                    (s) => getForegroundColor(s, Theme.of(context).brightness),
                  ),
                  backgroundColor: MaterialStateProperty.resolveWith(
                    (s) => getBackgroundColor(s, Theme.of(context).brightness),
                  ),
                ) ??
            ButtonStyle(
              padding: MaterialStateProperty.resolveWith(getDarkPadding),
              foregroundColor: MaterialStateProperty.resolveWith(
                (s) => getForegroundColor(s, Theme.of(context).brightness),
              ),
              backgroundColor: MaterialStateProperty.resolveWith(
                (s) => getBackgroundColor(s, Theme.of(context).brightness),
              ),
            ),
        onPressed: onPressed != null ? () => onPressed(context) : null,
      );
    }

    return ElevatedButton.icon(
      icon: SizedBox(
        width: 18,
        height: 18,
        child: GoogleIcon(),
      ),
      label: Text(label),
      style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                foregroundColor: MaterialStateProperty.resolveWith(
                  (s) => getForegroundColor(s, Theme.of(context).brightness),
                ),
                backgroundColor: MaterialStateProperty.resolveWith(
                  (s) => getBackgroundColor(s, Theme.of(context).brightness),
                ),
              ) ??
          ButtonStyle(
            foregroundColor: MaterialStateProperty.resolveWith(
              (s) => getForegroundColor(s, Theme.of(context).brightness),
            ),
            backgroundColor: MaterialStateProperty.resolveWith(
              (s) => getBackgroundColor(s, Theme.of(context).brightness),
            ),
          ),
      onPressed: onPressed != null ? () => onPressed(context) : null,
    );
  }
}
