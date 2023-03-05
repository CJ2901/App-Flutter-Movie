

import 'dart:async';
import 'dart:convert';

import 'package:app_movies/helpers/debouncer.dart';
import 'package:app_movies/models/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier {

  String _apiKey    = '619baf1692a8f0ff50b5d6553d369fd4';  
  String _baseURL   = 'api.themoviedb.org';
  String _language = 'es-ES';  

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  Map<int, List<Cast> > moviesCast = {}; // Para casos en que necesitan una ID
  List<Movie> onSearchMovies = [];
  

  int _popularPage = 0; // Para luego hacer infiniteScroll

  final debouncer = Debouncer(
    duration: Duration(milliseconds: 500),
     
  );

  final StreamController<List<Movie>> _suggestionStreamController = new StreamController.broadcast(); //Muchos objetos pueden estar suscritos a los cambios de ese stream
  Stream<List<Movie>> get suggestionStream => this._suggestionStreamController.stream;

  MoviesProvider(){
    print('MoviesProvider inicializado');
    this.getOnDisplayMovies();
    this.getPopularMovies();
  }

  Future<String> _getJsonData( String endpoint, [int page = 1] ) async {
    final url = Uri.https(_baseURL, endpoint,{
      'api_key' : _apiKey,
      'language':_language,
      'page'    : '$page',
    });

    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    final jsonData = await _getJsonData('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);

    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {
    
    _popularPage++;

    final jsonData = await _getJsonData('3/movie/popular', _popularPage);
    final popularResponse = PopularResponse.fromJson(jsonData);

    popularMovies = [ ...popularMovies ,...popularResponse.results];
    notifyListeners();
  }

  // El async convierte cualquier retorno en un future que resuelve ese valor
  
  // Tiene como argumento el idMovie
  Future< List<Cast> > getMovieCast(int idMovie) async {
    // Por el async deducimos que envía un Future a la fuerza
    // Puedo llamarlo y esperar a tener respuesta, eso se va a mostrar
    if (moviesCast.containsKey(idMovie)) return moviesCast[idMovie]!; 
    //Marca error porque pudiera ser que no exista pero obvio con la condicional sí va a existir así que colocamos !

    final jsonData = await _getJsonData('3/movie/$idMovie/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);

    moviesCast[idMovie] = creditsResponse.cast;
    return creditsResponse.cast;
  }

  // Tiene como argumento el query
   Future< List<Movie> > searchMovie(String query) async {

    final url = Uri.https(_baseURL, '3/search/movie',{
      'api_key' : _apiKey,
      'language':_language,
      'query'   : query,
    });

    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson( response.body);

    return searchResponse.movies;
  }

  void getSuggestionsByQuery( String searchTerm ){ //Meterá el query al Stream cuando el debounder emita el valor

    debouncer.value = '';
    debouncer.onValue =(value) async {
      final results = await this.searchMovie(value);
      this._suggestionStreamController.add(results); // Para que el Stream sepa que eso está sucediendo
      // el resultado debe ser lista de películas
    };

    final timer = Timer.periodic(const Duration(milliseconds : 300), ( _ ) {
      debouncer.value = searchTerm;
    });

    Future.delayed(const Duration( milliseconds : 301)).then(( _ ) => timer.cancel());

  }


} 