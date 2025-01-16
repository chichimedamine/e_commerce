import 'package:flutter/material.dart';

class FontsHelper {
  // Private constructor to prevent instantiation
  FontsHelper._();

  // Font weights
  static const FontWeight thin = FontWeight.w100;
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight black = FontWeight.w900;

  // Font family names
  static const String primaryFont = 'Rubik'; // Replace with your primary font
  static const String secondaryFont =
      'Poppins'; // Replace with your secondary font

  // Font styles for different text types
  static TextStyle heading1({
    Color? color,
    FontWeight weight = bold,
    double? height,
  }) {
    return TextStyle(
      fontFamily: primaryFont,
      fontSize: 32,
      fontWeight: weight,
      color: color,
      height: height,
    );
  }

  static TextStyle heading3({
    Color? color,
    FontWeight weight = semiBold,
    double? height,
  }) {
    return TextStyle(
      fontFamily: primaryFont,
      fontSize: 20,
      fontWeight: weight,
      color: color,
      height: height,
    );
  }

  static TextStyle heading4({
    Color? color,
    FontWeight weight = regular,
    double? height,
  }) {
    return TextStyle(
      fontFamily: primaryFont,
      fontSize: 18,
      fontWeight: weight,
      color: color,
      height: height,
    );
  }

  static TextStyle bodySmall({
    Color? color,
    FontWeight weight = regular,
    double? height,
  }) {
    return TextStyle(
      fontFamily: primaryFont,
      fontSize: 14,
      fontWeight: weight,
      color: color,
      height: height,
    );
  }

  static TextStyle button({
    Color? color,
    FontWeight weight = semiBold,
    double? height,
  }) {
    return TextStyle(
      fontFamily: primaryFont,
      fontSize: 16,
      fontWeight: weight,
      color: color,
      height: height,
    );
  }

  static TextStyle caption({
    Color? color,
    FontWeight weight = regular,
    double? height,
  }) {
    return TextStyle(
      fontFamily: primaryFont,
      fontSize: 12,
      fontWeight: weight,
      color: color,
      height: height,
    );
  }

  static TextStyle heading2({
    Color? color,
    FontWeight weight = semiBold,
    double? height,
  }) {
    return TextStyle(
      fontFamily: primaryFont,
      fontSize: 24,
      fontWeight: weight,
      color: color,
      height: height,
    );
  }

  static TextStyle bodyLarge({
    Color? color,
    FontWeight weight = regular,
    double? height, required FontWeight fontWeight,
  }) {
    return TextStyle(
      fontFamily: primaryFont,
      fontSize: 16,
      fontWeight: weight,
      color: color,
      height: height,
    );
  }

  static TextStyle bodyMedium({
    Color? color,
    FontWeight weight = regular,
    double? height,
  }) {
    return TextStyle(
      fontFamily: primaryFont,
      fontSize: 14,
      fontWeight: weight,
      color: color,
      height: height,
    );
  }

  // Custom font style generator
  static TextStyle customStyle({
    required double fontSize,
    String? fontFamily,
    FontWeight? fontWeight,
    Color? color,
    double? height,
    double? letterSpacing,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontFamily: fontFamily ?? primaryFont,
      fontSize: fontSize,
      fontWeight: fontWeight ?? regular,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
      decoration: decoration,
    );
  }
}
