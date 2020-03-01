import 'package:flutter/material.dart';


class AlertPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alert Page'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Mostrar Alert'),
          color: Colors.blue,
          onPressed: () => _mostarAlert(context),
          textColor: Colors.white,
          shape: StadiumBorder(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.exit_to_app),
        onPressed: (){
          Navigator.pop(context);
        },
      ),
    );
  }

  void _mostarAlert(BuildContext context){
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context){
        return AlertDialog(
          shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text('Titulo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Esta es una alerta de alertas'),
              SizedBox(height: 20,),
              FlutterLogo( size: 100.0, ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child:Text('Cancelar'),
              onPressed: ()=> Navigator.of(context).pop() ,
            ),
            FlatButton(
              child:Text('Ok'),
              onPressed: ()=>Navigator.of(context).pop(),
            )
          ],
        );
      }
    );
  }

}