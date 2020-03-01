import 'package:flutter/material.dart';

import 'dart:async';

class ListViewPage extends StatefulWidget {

  @override
  _ListViewPageState createState()=> _ListViewPageState();
  
}

class _ListViewPageState extends State<ListViewPage>{

  ScrollController _scrollController = new ScrollController();

  List<int> _listaNumeros = new List(); 
  int _ultimoItem = 0;
  bool _isLoadign = false;


  @override
  void initState() {
    super.initState();

    agregar10();


    _scrollController.addListener((){
      if(_scrollController.position.pixels  == _scrollController.position.maxScrollExtent ){
        //agregar10();
        fetchdata();
      };
    });
  }

  @override
  void dispose(){
    super.dispose();
    _scrollController.dispose();
  }


 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView'),
      ),
      body:Stack(
        children: <Widget>[
          _crearLista(),
          _crearLoading(),
        ],
      )
      
    );

  }

  Widget _crearLista(){

    return RefreshIndicator(
        onRefresh: obtenrPagina1,
        child: ListView.builder(
        itemCount: _listaNumeros.length,
        itemBuilder: ( BuildContext context, int index ){
          final imagen = _listaNumeros[index];
          return FadeInImage(
            image: NetworkImage('https://picsum.photos/500/400/?image=${imagen}'),
            placeholder: AssetImage('assets/jar-loading.gif'),
          );
        },
        controller: _scrollController,

      ),
    );

  }

  Widget _crearLoading(){
    if(_isLoadign){
      return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[ 
              CircularProgressIndicator()
            ],
          ),
          SizedBox(height: 20.0,)
        ],
      );
      
     
    }else{
      return Container();
    }
  }

  Future<Null> obtenrPagina1() async{
    final duration = new Duration(seconds: 2);
    new Timer(duration, (){
      _listaNumeros.clear();
      _ultimoItem++;
      agregar10();
    });
    return Future.delayed(duration);
  }
 
  Future<Null> fetchdata() async {

    _isLoadign = true;
    setState(() {});

    final duration = new Duration(seconds: 2);
    return new Timer(duration,respuestaHTTP);


  }

  void respuestaHTTP(){
    _isLoadign = false;
    _scrollController.animateTo(
      _scrollController.position.pixels + 300,
      curve: Curves.fastOutSlowIn,
      duration: Duration(milliseconds: 200),
    );
    agregar10();


  }

  void agregar10(){

    for (var i = 1; i < 10; i++) {

      _ultimoItem ++;
      _listaNumeros.add(_ultimoItem);

    }
    setState(() { });

  }
  
}