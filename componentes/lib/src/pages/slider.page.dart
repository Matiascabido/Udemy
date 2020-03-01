import 'package:flutter/material.dart';

class SliderPage extends StatefulWidget {

  @override
  _SliderPageState createState()=> _SliderPageState();
  
}

class _SliderPageState extends State<SliderPage>{


  double _valorSlider = 100.0;
  bool _bloquearCheck = false;

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sliders'),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 50.0),
        child: Column(
          children: <Widget>[
            _crearSlider(),
            _crearCheckbox(),
            _crearSwitch(),
            Expanded(child: _crearImagen()),
          ],
        ),
      ),
    );
  }


  Widget _crearSlider(){

    return Slider(
      activeColor: Colors.indigo,
      label: 'Tamaño',
      divisions: 20,
      value: _valorSlider,
      min: 10.0,
      max: 400.0,
      onChanged: _bloquearCheck != true ? ( valor ){
        setState(() {
           _valorSlider = valor ;
        });
      }: null

    );

  }

  Widget _crearCheckbox(){
    return CheckboxListTile(
      value: _bloquearCheck,
      onChanged: ( valor ){
        setState(() {
          _bloquearCheck = valor;
        });
      },
      title: Text('Bloqueo de slider check'),
    );
  }

  Widget _crearSwitch(){
    return SwitchListTile(
      value: _bloquearCheck,
      onChanged: ( valor ){
        setState(() {
          _bloquearCheck = valor;
        });
      },
      title: Text('Bloqueo de slider switch'),
    );
  }

  Widget _crearImagen(){
    return Image(
      image: NetworkImage('http://img1.wikia.nocookie.net/__cb20130730195131/comicdc/es/images/c/cf/Flash_(Barry_Allen)_001.jpg'),
      width: _valorSlider,
      fit: BoxFit.contain,
    );

  }








}
