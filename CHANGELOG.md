## [0.1.1] - 25 January 2021
- Fix: Changed `if (buttonThemeData == null) ` to `if (buttonThemeData?.style == null)` in `ArculusEmailButton` and `GenericEmailButton` to prevent exception in case of buttonThemeData is not null, but its style is null.

## [0.1.0] - 21 January 2021
- New: `isLoading` property to easily implement loading indicator to your button. When isLoading set to true, the button automatically uninteractive, making it easier to prevent accidental repeated taps. When in disabled mode, The button becomes translucent automatically.
- New: `BaseArculusButton` and `BaseGenericButton` makes you able to customize the buttons even more.
- New: `isEnabled` property to `GoogleLogo` and `AppleLogo`. When set to false, will apply 0.5 opacity to the icon.
- Improvement: Each Email, Google, and Apple button (both generic and arculus) based from `BaseArculusButton` for consistency.
- **Breaking:** Bumps minumum dart sdk to 2.8.0
- **Breaking:** Bumps minumum flutter sdk to 1.22.0

## [0.0.5] - 10 January 2021
- Google button will also check if `ElevatedButtonTheme` is using non-Rounded Rectangle Border and even resorts back to match `ButtonTheme` if no `ElevatedButtonTheme` set in theme. (Basically makes the widget more robust)

## [0.0.4] - 9 January 2021
- Decided to remove flutter_svg dependency and use png instead.

## [0.0.3] - 9 January 2021
- Update image links so they don't break in pub.dev

## [0.0.2] - 9 January 2021
- Turns out using relative link will break when published to pub.dev
- Various other adjustment to readme file.

## [0.0.1] - 9 Janyary 2021

- Generic email, google, and apple sign in buttons.
- Arculus style email, google, and apple sign in buttons.
- Plain GoogleLogo and AppleLogo