import 'package:app_movies/providers/movies_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class CastingCards extends StatelessWidget {
   
   final int idMovie;

  const CastingCards({
    super.key, 
    required this.idMovie
  });
  
  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context,listen: false);
    
    return FutureBuilder(
      future: moviesProvider.getMovieCast(idMovie),
      builder: (( _ , AsyncSnapshot< List<Cast> > snapshot ) {
        if ( !snapshot.hasData ) {
          return Container(
            constraints: const BoxConstraints(maxWidth: 150),
            height: 100,
            child: const CupertinoActivityIndicator(),
          );

        }
          final List<Cast> cast = snapshot.data!;

          return Container(
            margin: const EdgeInsets.only( bottom: 10 ),
            width: double.infinity,
            height: 200,
            child: ListView.builder(
              itemCount: cast.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: ( _ , index) => _CastCard(actor: cast[index]),
            ),
          );
      }) ,
    );

    
  }
}

class _CastCard extends StatelessWidget {

  final Cast actor;

  const _CastCard({
    Key? key, 
    required this.actor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      width: 110,
      height: 120,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'),
              image:  NetworkImage(actor.fullProfilePath),
              height: 115,
              width: 100,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            actor.name,
            style: const TextStyle(
              fontSize: 14,
              
            ),
          ),
          Text(
            actor.character!,
            style: const TextStyle(
              fontSize: 10,
              fontStyle: FontStyle.italic,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}