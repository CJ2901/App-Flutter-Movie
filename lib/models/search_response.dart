import 'dart:convert';

import 'package:app_movies/models/models.dart';

class SearchResponse {
    SearchResponse({
        required this.page,
        required this.movies,
        required this.totalPages,
        required this.totalResults,
    });

    int page;
    List<Movie> movies;
    int totalPages;
    int totalResults;

    factory SearchResponse.fromJson(String str) => SearchResponse.fromMap(json.decode(str));

    // String toJson() => json.encode(toMap());

    factory SearchResponse.fromMap(Map<String, dynamic> json) => SearchResponse(
        page: json["page"],
        movies: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

    // Map<String, dynamic> toMap() => {
    //     "page": page,
    //     "results": List<dynamic>.from(movies.map((x) => x.toMap())),
    //     "total_pages": totalPages,
    //     "total_results": totalResults,
    // };
}
