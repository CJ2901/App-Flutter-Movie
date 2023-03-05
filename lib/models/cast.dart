import 'dart:convert';

class Cast {
    Cast({
        required this.adult,
        required this.gender,
        required this.id,
        required this.knownForDepartment,
        required this.name,
        required this.originalName,
        required this.popularity,
        this.profilePath,
        this.castId,
        this.character,
        required this.creditId,
        this.order,
        this.department,
        this.job,
    });

    bool adult;
    int gender;
    int id;
    String knownForDepartment;
    String name;
    String originalName;
    double popularity;
    String? profilePath;
    int? castId;
    String? character;
    String creditId;
    int? order;
    String? department;
    String? job;

    // Se crea un getter para cambiar lo recibido y completar el enlace de una imagen
    get fullProfilePath {
      if ( this.profilePath != null ) {
        return 'https://image.tmdb.org/t/p/w500${ this.profilePath }';
      }
        
      return 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png';
    }

    factory Cast.fromJson(String str) => Cast.fromMap(json.decode(str));

    // String toJson() => json.encode(toMap());

    factory Cast.fromMap(Map<String, dynamic> json) => Cast(
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"]?.toDouble(),
        profilePath: json["profile_path"],
        castId: json["cast_id"],
        character: json["character"],
        creditId: json["credit_id"],
        order: json["order"],
        department: json["department"],
        job: json["job"],
    );

    // Map<String, dynamic> toMap() => {
    //     "adult": adult,
    //     "gender": gender,
    //     "id": id,
    //     "known_for_department": knownForDepartment,
    //     "name": name,
    //     "original_name": originalName,
    //     "popularity": popularity,
    //     "profile_path": profilePath,
    //     "cast_id": castId,
    //     "character": character,
    //     "credit_id": creditId,
    //     "order": order,
    //     "department": department,
    //     "job": job,
    // };
}
