import 'package:flutter/material.dart';

import 'package:app_movies/screens/screens.dart';
import 'package:app_movies/providers/movies_provider.dart';

import 'package:provider/provider.dart';
import 'theme/app_theme.dart';


void main() => runApp( AppState() );

class AppState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: ( _ ) => MoviesProvider(), lazy: false),
        ],
        child: MyApp(),
      );
  }   
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Películas',
      initialRoute: 'home',
      routes: {
        'home':    ( _ ) => const HomeScreen(),
        'details': ( _ ) => const DetailsScreen(),
      },
      theme: AppTheme.lighTheme,
    );
  }
}