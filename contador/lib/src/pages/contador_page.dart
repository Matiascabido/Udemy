import 'package:flutter/material.dart';


class ContadorPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>  _ContadorPageState();
}


class _ContadorPageState extends State<ContadorPage>{

  final TextStyle _estilo = new TextStyle(fontSize: 20);

  int _contador = 0;

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text('Titulo en mi App'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Numero de Clicks',style: _estilo),
            SizedBox(height: 16.0,),
            Text('$_contador',style: _estilo)
          ],
        ),
      ),
      floatingActionButton: _crearBotones()

    );
  }

  Widget _crearBotones(){

    return Padding(
      padding: EdgeInsets.only(left:24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FloatingActionButton(onPressed: _restar, child: Icon(Icons.remove),), 
          FloatingActionButton(onPressed: _aCero, child: Icon(Icons.exposure_zero),),
          FloatingActionButton(onPressed: _sumar, child: Icon(Icons.add),)
        ],
      ),
    );
  }

void _aCero(){
  setState(() => _contador = 0);
}

void _sumar(){
  setState(() => _contador ++);
}

void _restar(){
  setState(() =>  _contador != 0 ? _contador -- : _contador = 0);
}




}
