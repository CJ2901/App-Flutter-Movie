import 'package:flutter/material.dart';

import '../models/models.dart';

class MovieSlider extends StatefulWidget {

  final List<Movie> movies;
  final String? nameCategory;
  final Function onNextPage;


  const MovieSlider({
    super.key, 
    required this.movies,
    this.nameCategory, 
    required this.onNextPage
  }); 

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {

  final ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {

      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 600 ) {
        // 'Ya se abre la otra page'
        widget.onNextPage();
        
      }

    });

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      
      width: double.infinity,
      height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          if ( widget.nameCategory != null )(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text('${widget.nameCategory}', 
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
          )),

          
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              itemBuilder: ( _ , int index) =>_MoviePoster( movie: widget.movies[index] )
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),

    );
  }
}

class _MoviePoster extends StatelessWidget {
  
  final Movie movie;

  const _MoviePoster({
    required this.movie, 
  });

  @override
  Widget build(BuildContext context) {

    movie.heroId = 'slider-${movie.id}';

    return Container(
      width: 130,
      height: 190,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [

          GestureDetector(
            onTap: () => Navigator.pushNamed(context,'details',arguments: movie),
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(movie.fullPosterImg),
                  width: 130,
                  height: 190,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox( height: 5),

          Text(
            movie.title,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )

        ],
      ),
    );
  }
}