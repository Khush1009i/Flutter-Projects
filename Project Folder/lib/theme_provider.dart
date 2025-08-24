import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void setTheme(ThemeMode theme) {
    _themeMode = theme;
    notifyListeners();
  }

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    notifyListeners();
  }

  // Light theme
  ThemeData get lightTheme => ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFF4ECDC4),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF4ECDC4),
      secondary: Color(0xFF45B7D1),
      background: Color(0xFFF8F9FA),
      surface: Color(0xFFFFFFFF),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onBackground: Color(0xFF2D2B2B),
      onSurface: Color(0xFF2D2B2B),
    ),
    scaffoldBackgroundColor: const Color(0xFFF8F9FA),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFFFFFFF),
      foregroundColor: Color(0xFF2D2B2B),
      elevation: 4,
      titleTextStyle: TextStyle(
        color: Color(0xFF2D2B2B),
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
    ),
    textTheme: TextTheme(
      displayLarge: const TextStyle(
        fontSize: 42,
        fontWeight: FontWeight.w800,
        color: Color(0xFF2D2B2B),
      ),
      displayMedium: TextStyle(
        fontSize: 20,
        color: Colors.grey[700],
        fontWeight: FontWeight.w300,
      ),
      titleLarge: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: Color(0xFF2D2B2B),
      ),
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    useMaterial3: true,
  );

  // Dark theme
  ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF4ECDC4),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF4ECDC4),
      secondary: Color(0xFF45B7D1),
      background: Color(0xFF1A1A1A),
      surface: Color(0xFF2D2B2B),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onBackground: Colors.white,
      onSurface: Colors.white,
    ),
    scaffoldBackgroundColor: const Color(0xFF1A1A1A),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF2D2B2B),
      foregroundColor: Color(0xFFD4AF37),
      elevation: 4,
      titleTextStyle: TextStyle(
        color: const Color.fromRGBO(212, 175, 55, 1),
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
    ),
    textTheme: TextTheme(
      displayLarge: const TextStyle(
        fontSize: 42,
        fontWeight: FontWeight.w800,
        color: Color(0xFFD4AF37),
      ),
      displayMedium: TextStyle(
        fontSize: 20,
        color: Colors.grey[400],
        fontWeight: FontWeight.w300,
      ),
      titleLarge: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: Color(0xFFD4AF37),
      ),
    ),
    cardTheme: CardThemeData(
      color: const Color(0xFF2D2B2B),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    useMaterial3: true,
  );
}
