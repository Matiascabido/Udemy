import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate {

  String seleccion = '';

  final peliculasProvider = new PeliculasProvider();

  final peliculas = [
    'Batman',
    'Superman',
    'Hitman 47',
    'Capitan America',
    'Hombres de Negro',
    'Colas Calientes 4',
    'Ironman 3',
  ];

  final peliculasRecientes = [
    'Spiderman',
    'Sonic'
  ];


  @override
  List<Widget> buildActions(BuildContext context) {
    //ACCIONES DE NUESTRO APPBAR 
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //ICONO  A LA IZQUIERDA DEL APPBAR
    return IconButton(
      icon: AnimatedIcon(
        icon:AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close( context, null );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //CREA LOS RESULTADOS A MOSTRAR
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color:Colors.blueAccent,
        child: Text(seleccion),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //CREA LA SUGERENCIAS QUE APARECEN CUANDO LA PRERSONA ESCRIBE
    if( query.isEmpty ){
      return Container();
    }


   return FutureBuilder(
      future: peliculasProvider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        if( snapshot.hasData ){

          final peliculas = snapshot.data;

          return  ListView(
            children: peliculas.map( (pelicula) {
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage( pelicula.getPosterImg() ),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  width: 50.0,
                  fit: BoxFit.contain,
                ),
                title: Text( pelicula.title ),
                subtitle: Text( pelicula.originalTitle ),
                onTap: (){
                  close(context , null);
                  pelicula.uniqueId = '';
                  Navigator.pushNamed(context, 'detalle',arguments: pelicula);
                },
              );
            }).toList(),
          );

        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );


  }


}




















  //TODO: EJEMPLO DE UNA SUGUERENCIA SIN API
  // @override
  // Widget buildSuggestions(BuildContext context) {
  //   //CREA LA SUGERENCIAS QUE APARECEN CUANDO LA PRERSONA ESCRIBE

  //   final listaSugerida = ( query.isEmpty ) ? 
  //   peliculasRecientes : 
  //   peliculas.where((p)=> p.toLowerCase().startsWith(query.toLowerCase())).toList();

  //   return ListView.builder(
  //     itemCount: listaSugerida.length,
  //     itemBuilder: (context,index){
  //       return ListTile(
  //         leading: Icon( Icons.movie),
  //         title: Text(listaSugerida[index]),
  //         onTap: (){
  //           seleccion = listaSugerida[index];
  //           showResults( context );
  //         },
  //       );
  //     },

  //   );
  // }


