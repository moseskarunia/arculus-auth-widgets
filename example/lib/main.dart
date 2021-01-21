import 'package:arculus_auth_widgets/arculus_auth_widgets.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  OutlinedBorder getBorder(Set<MaterialState> states) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.light,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
          shape: MaterialStateProperty.resolveWith(getBorder),
        )),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
          shape: MaterialStateProperty.resolveWith(getBorder),
        )),
      ),
      home: MyHomePage(title: 'Arculus Auth Widgets'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            SizedBox(height: 32),
            GenericEmailButton(
              label: 'Sign in with Email',
              onPressed: (_) {},
            ),
            SizedBox(height: 8),
            GenericAppleButton(
              label: 'Sign in with Apple',
              onPressed: (_) {},
            ),
            SizedBox(height: 8),
            Theme(
              data: Theme.of(context).copyWith(brightness: Brightness.dark),
              child: GenericGoogleButton(
                label: 'Sign in with Google',
                onPressed: (_) {},
                isLoading: true,
              ),
            ),
            SizedBox(height: 64),
            ArculusEmailButton(
              label: 'Sign in with Email',
              onPressed: (_) {},
            ),
            SizedBox(height: 16),
            ArculusAppleButton(
              label: 'Sign in with Apple',
              onPressed: (_) {},
              isLoading: true,
            ),
            SizedBox(height: 16),
            ArculusGoogleButton(
              label: 'Sign in with Google',
              onPressed: (_) {},
            ),
          ],
        ),
      ),
    );
  }
}
