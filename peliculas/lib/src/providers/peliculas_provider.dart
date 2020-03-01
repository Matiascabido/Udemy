import 'package:peliculas/src/models/actores_model.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class PeliculasProvider{

  //VARIABLES GLOBALES DE LA CLASE

  String _apiKey    = 'da8fff4ed915f66f545bc45eebc6dcf4';
  String _url       = 'api.themoviedb.org';
  String _lenguage  = 'es-ES';

  int _popularesPage = 0;
  bool _cargando = false;

  List<Pelicula> _populares = new List();


  final _popularesStreamControler = StreamController<List<Pelicula>>.broadcast();


  //FUNCION PRINCIPAL QUE MEDIANTE EL LINK OBTIENE LOS DATOS
  Future<List<Pelicula>> _procesarRespuesta(Uri url) async{
    final res = await http.get(url);

    final decodedData = json.decode(res.body);

    final peliculas = new Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;
  }

  Future<List<Actor>> _procesarRespuestaActores(Uri url) async{
    final resp =  await http.get(url);

    final decodeData = json.decode(resp.body);

    final cast = new Cast.fromJsonList(decodeData['cast']);

    return cast.actores;
  }




  //FUNCIONES STREAM DE LA CLASE
  Function(List<Pelicula>) get populuaresSink => _popularesStreamControler.sink.add;

  Stream<List<Pelicula>> get popularesStream => _popularesStreamControler.stream;




  //FUNCION FUTURA PARA OBTENER DATOS DE DISTINTO TIPO (CAMBIA EL URL )
  Future<List<Pelicula>>  getEnCines() async {

    final url = Uri.https(_url, '3/movie/now_playing',{
      'api_key' : _apiKey,
      'lenguage' : _lenguage,
    });

    return await _procesarRespuesta(url);

  }

  Future<List<Pelicula>>  getPopulares() async {

    if(_cargando) return [];

    _cargando = true;

    _popularesPage++;


    final url = Uri.https(_url, '3/movie/popular',{
      'api_key'   : _apiKey,
      'lenguage'  : _lenguage,
      'page'      :_popularesPage.toString(),
    });

    final resp = await _procesarRespuesta(url);

    _populares.addAll(resp);

    populuaresSink( _populares );

    _cargando = false;

    return resp;

  }

  Future<List<Actor>>  getActores(String peliculaId) async {

    final url = Uri.https(_url, '3/movie/$peliculaId/credits',{
      'api_key' : _apiKey,
      'lenguage' : _lenguage,
    });
      
    return _procesarRespuestaActores(url);
  }

  Future<List<Pelicula>>  buscarPelicula( String query ) async {

    final url = Uri.https(_url, '3/search/movie',{
      'api_key'   : _apiKey,
      'lenguage'  : _lenguage,
      'query'     : query
    });

    return await _procesarRespuesta(url);

  }



  void disposeStreams(){
    _popularesStreamControler?.close();
  }


}