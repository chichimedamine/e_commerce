import 'package:flutter/material.dart';

class ColorsHelper {
  // Private constructor to prevent instantiation
  ColorsHelper._();

  // App theme colors
  static const Color primary = Color(0xFF2196F3);
  static const Color secondary = Color(0xFF03DAC6);
  static const Color accent = Color(0xFFFF4081);
  
  // Common colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  

  static const Color red = Color(0xFFFF0000);
  static const Color pink = Color(0xFFFF69B4);
  static const Color purple = Color(0xFF8E24AA);
  static const Color deepPurple = Color(0xFF6200EE);
  static const Color indigo = Color(0xFF3F51B5);
  static const Color blue = Color(0xFF2196F3);
  static const Color lightBlue = Color(0xFF03A9F4);
  static const Color cyan = Color(0xFF00BCD4);
  static const Color teal = Color(0xFF009688);
  static const Color green = Color(0xFF4CAF50);
  static const Color lightGreen = Color(0xFF8BC34A);
  static const Color lime = Color(0xFFCDDC39);
  static const Color yellow = Color(0xFFF9A825);
  static const Color amber = Color(0xFFFFC107);
  static const Color orange = Color(0xFFFF9800);
  static const Color deepOrange = Color(0xFFFF5252);
  static const Color transparent = Colors.transparent;
  
  // Gray scale
  static const Color gray100 = Color(0xFFF5F5F5);
  static const Color gray200 = Color(0xFFEEEEEE);
  static const Color gray300 = Color(0xFFE0E0E0);
  static const Color gray400 = Color(0xFFBDBDBD);
  static const Color gray500 = Color(0xFF9E9E9E);
  static const Color gray600 = Color(0xFF757575);
  static const Color gray700 = Color(0xFF616161);
  static const Color gray800 = Color(0xFF424242);
  static const Color gray900 = Color(0xFF212121);
  
  // Status colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);

  // Helper methods
  static Color withOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }

  // Convert hex string to Color
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  // Convert Color to hex string
  static String toHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0').substring(2)}';
  }

  // Create MaterialColor from Color
  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }

    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }

    return MaterialColor(color.value, swatch);
  }
}