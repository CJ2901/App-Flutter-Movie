import 'package:app_movies/models/models.dart';
import 'package:app_movies/providers/movies_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  
  final List<Movie> movies;

  MovieSearchDelegate(this.movies);

  @override
  String? get searchFieldLabel => 'Buscar película';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return[
      IconButton(
        onPressed: () => query = '',
        icon: const Icon(Icons.clear)
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return  IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return  Text('Este es el resultado de buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    
    if (query.isEmpty) {
      return _EmptyWidget();
    }

    final moviesProvider = Provider.of<MoviesProvider>(context,listen: false);
    moviesProvider.getSuggestionsByQuery( query );

    return StreamBuilder(
      stream: moviesProvider.suggestionStream, // Cuando el suggestionStream emita un valor, el StreamBuilder se va a redibujar
      builder: ( _ , AsyncSnapshot< List <Movie> > snapshot) {
        if (!snapshot.hasData) return _EmptyWidget();
        
        final movies = snapshot.data!;

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) => _MovieItem(movie: movies[index]),
        );

      },
    );
  }

}

class _MovieItem extends StatelessWidget {
  
  final Movie movie;

  const _MovieItem({
    super.key, 
    required this.movie
  });

  @override
  Widget build(BuildContext context) {

    movie.heroId = 'search-${movie.id}';

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context,'details',arguments: movie),
      child: ClipRRect(
        child: ListTile(
          leading: Hero(
            tag: movie.heroId!,
            child: FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: NetworkImage( movie.fullPosterImg ),
              width: 50,
              fit: BoxFit.contain,
            ),
          ),
          title: Text(movie.title),
          subtitle: Text(movie.originalTitle),
        )
      )
    );
  }
}

class _EmptyWidget extends StatelessWidget {
  const _EmptyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        child: Icon(Icons.movie_creation_outlined,color: Colors.black38,size: 130,),
      ),
    );
  }
}