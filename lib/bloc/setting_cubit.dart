import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  bool isDark = false;
  TextStyle appFont = GoogleFonts.roboto();

  SettingCubit()
      : super(AppTheme(
            theme: ThemeData(
          textTheme: textTheme(GoogleFonts.roboto()),
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(backgroundColor: Colors.white24),
          primaryColor: Colors.white54,
        )));

  Future<void> currentFont() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString('font') == 'roboto') {
      appFont = GoogleFonts.roboto();
    } else if (pref.getString('font') == 'arapey') {
      appFont = GoogleFonts.arapey();
    } else if (pref.getString('font') == 'bahiana') {
      appFont = GoogleFonts.bahiana();
    } else if (pref.getString('font') == 'marvel') {
      appFont = GoogleFonts.marvel();
    } else {
      appFont = GoogleFonts.roboto();
    }
  }

  void currentTheme() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    switch (pref.getString('theme')) {
      case 'light':
        setTheme('light');
        break;
      case 'dark':
        isDark = true;
        setTheme('dark');
        break;
      case 'orange':
        setTheme('orange');
        break;
      case 'blue':
        setTheme('blue');
        break;
    }
  }

  void setTheme(String theme) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    switch (theme) {
      case 'light':
        emit(AppTheme(
            theme: ThemeData(
          textTheme: textTheme(appFont),
              elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey)),
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(color: Colors.black12),
          primaryColor: Colors.white54,
        )));
        break;
      case 'dark':
        emit(AppTheme(
            theme: ThemeData(
          textTheme: textTheme(appFont.copyWith(color: Colors.white)),
          useMaterial3: true,
              elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey)),
          scaffoldBackgroundColor: const Color(0xFF303030),
          appBarTheme: const AppBarTheme(color: Colors.black),
          primaryColor: Colors.black26,
        )));
        break;
      case 'orange':
        emit(AppTheme(
            theme: ThemeData(
          textTheme: textTheme(appFont),
          useMaterial3: true,
              elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrangeAccent)),
          scaffoldBackgroundColor: Colors.orangeAccent,
          appBarTheme: const AppBarTheme(backgroundColor: Colors.deepOrangeAccent),
          primaryColor: Colors.deepOrange,
        )));
        break;
      case 'blue':
        emit(AppTheme(
            theme: ThemeData(
                useMaterial3: true,
                elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent)),
                textTheme: textTheme(appFont),
                scaffoldBackgroundColor: Colors.lightBlueAccent,
                appBarTheme: const AppBarTheme(backgroundColor: Colors.blueAccent),
                primaryColor: Colors.blueAccent)));
        break;
    }
    pref.setString('theme', theme);
  }

  void changeFont(String fontName, TextStyle font, bool isDark) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('font', fontName);
    ThemeData newTheme = state.theme.copyWith(
      textTheme:
          textTheme(font.copyWith(color: isDark ? Colors.white : Colors.black)),
    );
    emit(AppTheme(theme: newTheme));
  }
}

TextTheme textTheme(TextStyle style) {
  return TextTheme(
    displayLarge: style,
    displayMedium: style,
    displaySmall: style,
    headlineMedium: style,
    headlineSmall: style,
    titleLarge: style,
    titleMedium: style,
    titleSmall: style,
    bodyLarge: style,
    bodyMedium: style,
    bodySmall: style,
    labelLarge: style,
    labelSmall: style,
    labelMedium: style,
  );
}
