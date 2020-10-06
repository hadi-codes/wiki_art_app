import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();
  static const Color pink = Color(0xFFF2389E);
  static const Color blue = Color(0xFF0122CA);
  static const Color grey = Color(0xFF7E7E7E);
  static const Color white = Color(0xFFFEFEFE);
  static const Color black = Color(0xFF0D0D0D);

  static final ThemeData themeData = ThemeData(
    primaryColor: blue,
    dialogBackgroundColor: black,
    accentColor: pink,
    primarySwatch: Colors.pink,
    backgroundColor: black,
    dividerColor: pink,
    scaffoldBackgroundColor: black,
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
        elevation: 0,
        color: black,
        textTheme: AppTheme.textTheme.apply(bodyColor: white),
        iconTheme: IconThemeData(
          color: pink,
        )),
    textTheme: AppTheme.textTheme,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static final TextTheme textTheme = TextTheme(
    headline1: GoogleFonts.montserrat(
        fontSize: 97, fontWeight: FontWeight.w300, letterSpacing: -1.5),
    headline2: GoogleFonts.montserrat(
        fontSize: 61, fontWeight: FontWeight.w300, letterSpacing: -0.5),
    headline3:
        GoogleFonts.montserrat(fontSize: 48, fontWeight: FontWeight.w400),
    headline4: GoogleFonts.montserrat(
        fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    headline5:
        GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.w400),
    headline6: GoogleFonts.montserrat(
        fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
    subtitle1: GoogleFonts.montserrat(
        fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
    subtitle2: GoogleFonts.montserrat(
        fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
    bodyText1: GoogleFonts.montserrat(
        fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
    bodyText2: GoogleFonts.montserrat(
        fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    button: GoogleFonts.montserrat(
        fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
    caption: GoogleFonts.montserrat(
        fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
    overline: GoogleFonts.montserrat(
        fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
  );
}
