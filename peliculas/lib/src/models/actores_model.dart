class Cast{

  List<Actor> actores = new List();

  Cast.fromJsonList( List<dynamic> jsonList ){

    if(jsonList == null) return;

    jsonList.forEach((item){

      final actor = Actor.fromJsonMap(item);
      actores.add(actor);

    });

  }


}


class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });


  Actor.fromJsonMap(Map<String,dynamic> json){ 
    id             = json['id'];
    castId         = json['cast_id'];
    creditId       = json['credit_id'];
    character      = json['character'] ;
    gender         = json['gender'];
    name           = json['name'];
    order          = json['order'];
    profilePath    = json['profile_path'];
   
  }

getFoto(){
    if(this.profilePath == null)
      return 'https://www.nutecoweb.com/wp-content/uploads/2014/12/errores-paginas-web-albacete.jpg';
    else
      return 'https://image.tmdb.org/t/p/w500/${this.profilePath}';
  }

}