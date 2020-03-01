import 'package:flutter/material.dart';


class HomePage extends StatelessWidget{

  final TextStyle estilo = new TextStyle(fontSize: 20);

  final int contador = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Titulo en mi App Bar'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Numero de Clicks',style: estilo),
            SizedBox(height: 16.0,),
            Text('$contador',style: estilo)
          ],
        ),
      ),
      floatingActionButton: 
      FloatingActionButton(
        onPressed: (){
          
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: 
      FloatingActionButtonLocation.centerFloat,
    );
  }

}