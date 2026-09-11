import 'package:flutter/material.dart';

class Apptheme
{
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xff111111),
    
    colorScheme: const ColorScheme.dark(primary: Color(0xff7B61FF)),
    
    appBarTheme: const AppBarTheme(backgroundColor: Color(0xff111111), elevation: 0,),
    
    cardColor: const Color(0xff1C1C1C),
  );
}