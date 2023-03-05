import 'package:flutter/material.dart';

class AppTheme {
  // Color primario
  static const Color primary = Color.fromARGB(255, 3, 65, 180);

  static final ThemeData lighTheme = ThemeData.light().copyWith(

      // Appbar theme
      appBarTheme: const AppBarTheme(
        color: primary, 
        elevation: 0
      ),

      // TextButton Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom( foregroundColor: primary),
      ),

      // FloatingActionButtons
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primary,
        elevation: 5
      ),

      // ElevatedButtons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.indigo,
          shape: const StadiumBorder(),
          elevation: 0
        ),
      ),

      inputDecorationTheme: const InputDecorationTheme(
        floatingLabelStyle: TextStyle( color: primary),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primary),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), topRight: Radius.circular(10))
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primary),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), topRight: Radius.circular(10))
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: primary),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), topRight: Radius.circular(10))
        ),
      )

  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
      
      scaffoldBackgroundColor: const Color.fromARGB(0,17, 27, 33),

      // Appbar theme
      appBarTheme: const AppBarTheme(
        color: primary, 
        elevation: 0
      ),

      // TextButton Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom( foregroundColor: primary),
      )

  );


}
