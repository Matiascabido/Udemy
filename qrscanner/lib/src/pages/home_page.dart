import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:qrscanner/src/providers/db_provider.dart';

import 'direcciones_page.dart';
import 'mapas_page.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Qr Scanner'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.delete_forever),
              onPressed: (){},
            )
          ],
        ),
        body: _callPage(currentIndex),
        bottomNavigationBar: _crearBottomNaivigationBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.filter_center_focus),
          onPressed: _scanQR,
          backgroundColor: Theme.of(context).primaryColor,
        ),

    );
  }



    // METODOS

  _scanQR() async {

      String futureString = 'https://www.linkedin.com/in/matias-cabido-40748a158';

      // try {

      //   futureString = await BarcodeScanner.scan();

        
      // } catch (e) {

      //   futureString = e.toString();

      // }

      // print('FututeSTRING : $futureString');

      if( futureString != null){

        final scan = ScanModel( valor: futureString );
        
        DBProvider.db.nuevoScan( scan );

        

      }

  }


    // FUNCIONES DE CREACION

  Widget _callPage(int paginaActual){

      switch ( paginaActual ) {
        case 0: return MapasPage();
        case 1: return DireccionesPage();
        default:
          return MapasPage();
      }

  }


  Widget _crearBottomNaivigationBar(){

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index){
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text('map')
        ), 
        BottomNavigationBarItem(
          icon: Icon(Icons.brightness_5),
          title: Text('Direcciones')
        )

      ],

    );



  }








}