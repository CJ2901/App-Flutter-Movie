import 'package:app_movies/models/models.dart';
import 'package:app_movies/widgets/widgets.dart';
import 'package:flutter/material.dart';

import 'package:app_movies/theme/app_theme.dart';



class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Cambiar por una instancia de clase
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    
    // final detailsProvider = Provider.of<MoviesProvider>(context);
    // final details = detailsProvider.getDetailsMovies(movie.id.toString()) ;
    // print('Aqui audaz');
    // print(details);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(movie: movie,), // Contiene un SliverAppBar

          // En clase usan otra opción que es
          // SliverList(
          //   delegate: SliverChildListDelegate(

          //   )
          // ),
          SliverToBoxAdapter(
              child: Column(
            children: [
              _PosterAndTitle(movie: movie),
              const SizedBox(height: 20),
              _OverView(movie: movie,),

              const SizedBox(height: 20),
              CastingCards(idMovie: movie.id),
            ],
          )),
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {

  final Movie movie;
  
  const _CustomAppBar({
    Key? key, 
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppTheme.primary,
      expandedHeight: 200,
      floating: false,
      pinned: false, // Para anclar el encabezado
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0), //Quita el padding debajo del titulo
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(bottom: 10),
          color: Colors.black12,
          child: Text(
            movie.title,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'),
          image: NetworkImage( movie.fullBackdropPath ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  
  final Movie movie;
  
  const _PosterAndTitle({
    Key? key, 
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(movie.fullPosterImg),
                  height: double.infinity,
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title,
                      style: textTheme.headline5),
                  Text(movie.originalTitle,
                      style: const TextStyle(
                        fontStyle: FontStyle.italic
                      ),
                      ),
                  Row(
                    children: [
                      Row(
                        children: List.generate((movie.voteAverage.ceil() ~/ 2), (index) {
                          return const Icon(Icons.star,
                              size: 20, color: Colors.amber);
                        }),
                      ),
                      const SizedBox(width: 5),
                      Text(movie.voteAverage.toString(), style: textTheme.caption)
                    ],
                  )
                ], 
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _OverView extends StatelessWidget {
  
  final Movie movie;

  const _OverView({
    Key? key, 
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}
