import 'package:app_movies/search/search_delegate.dart';
import 'package:flutter/material.dart';

import 'package:app_movies/widgets/widgets.dart';

import 'package:app_movies/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
   
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Películas en cines'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search_outlined),
            onPressed: () => showSearch(context: context, delegate: MovieSearchDelegate(moviesProvider.onSearchMovies)
            )
          ) ,
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Tarjetas principales
            CardSwipper( movies: moviesProvider.onDisplayMovies ), 

            // Slider de películas
            MovieSlider( 
              movies: moviesProvider.popularMovies,
              nameCategory: 'Últimas películas populares',
              onNextPage: () => moviesProvider.getPopularMovies(),

            ),
          ],
        ),
      )
    );
  }
}