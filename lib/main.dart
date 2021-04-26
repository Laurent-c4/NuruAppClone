import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nuru_clone_app/pages/home_page.dart';
import 'package:nuru_clone_app/provider/theme_provider.dart';
import 'package:provider/provider.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Specifies the set of orientations the application interface can
  /// be displayed in.
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = 'Nuru App Clone';

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    builder: (context, _) {
      final themeProvider = Provider.of<ThemeProvider>(context);

      return MaterialApp(
        title: title,
        themeMode: themeProvider.themeMode,
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        home: HomePage(),
      );
    },
  );
}
