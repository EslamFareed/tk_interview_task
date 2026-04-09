import 'package:flutter/material.dart';

abstract class AppTheme {
  static const Color _background = Color(0xFF0A0A0F);
  static const Color _surface = Color(0xFF13131A);
  static const Color _card = Color(0xFF1C1C26);
  static const Color _accent = Color(0xFF6C63FF);
  static const Color _accentLight = Color(0xFF9D97FF);
  static const Color _onBackground = Color(0xFFF0F0F8);
  static const Color _onSurface = Color(0xFFB0B0C8);

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: _background,
        colorScheme: const ColorScheme.dark(
          primary: _accent,
          secondary: _accentLight,
          surface: _surface,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: _onBackground,
          error: Color(0xFFCF6679),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: _background,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            color: _onBackground,
            fontSize: 24,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
          iconTheme: IconThemeData(color: _onBackground),
        ),
        cardTheme: CardThemeData(
          color: _card,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            color: _onBackground,
            fontSize: 28,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
          headlineMedium: TextStyle(
            color: _onBackground,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
          titleLarge: TextStyle(
            color: _onBackground,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          titleMedium: TextStyle(
            color: _onBackground,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          bodyMedium: TextStyle(
            color: _onSurface,
            fontSize: 13,
          ),
          labelMedium: TextStyle(
            color: _accentLight,
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      );
}
