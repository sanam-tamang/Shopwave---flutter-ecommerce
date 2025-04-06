import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primarySeedColor = Color(0xFF1565C0); 
const Color secondarySeedColor = Color(0xFFEF6C00); 
const Color tertiarySeedColor = Color(0xFF2E7D32); 

final ColorScheme schemeLight = SeedColorScheme.fromSeeds(
  brightness: Brightness.light,
  primaryKey: primarySeedColor,
  secondaryKey: secondarySeedColor,
  tertiaryKey: tertiarySeedColor,
  tones: FlexTones.vivid(Brightness.light), 
);

final ColorScheme schemeDark = SeedColorScheme.fromSeeds(
  brightness: Brightness.dark,
  primaryKey: primarySeedColor,
  secondaryKey: secondarySeedColor,
  tertiaryKey: tertiarySeedColor,
  tones: FlexTones.highContrast(Brightness.dark), 
);

ThemeData lightTheme(BuildContext context) => ThemeData(
      colorScheme: schemeLight,
      textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
    );
ThemeData darkTheme(BuildContext context) => ThemeData(
      colorScheme: schemeDark,
      textTheme: GoogleFonts.latoTextTheme().apply(
          bodyColor: schemeDark.onSurface, displayColor: schemeDark.onSurface),
    );
