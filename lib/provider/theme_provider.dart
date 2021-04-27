import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class AppThemes {
  const AppThemes();

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Color(0xFF121212),
    primaryColor: Colors.orange[200],
    accentColor: Colors.purple[200],
    disabledColor: Color(0xFF1D1D1D),
    colorScheme: ColorScheme.dark(),
    iconTheme: IconThemeData(color:Colors.orange[200]),
    bottomAppBarColor: Colors.black38
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Color(0xFFE5E5E5),
    primaryColor: Color(0xFFF6B21A),
    colorScheme: ColorScheme.light(),
    disabledColor: Colors.white,
    iconTheme: IconThemeData(color: Color(0xFFF6B21A)),
    bottomAppBarColor: Colors.white60
  );

  static const Color loginGradientStart = Color(0xFFfbab66);
  static const Color loginGradientEnd = Color(0xFFF6B21A);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: <Color>[loginGradientStart, loginGradientEnd],
    stops: <double>[0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

}
