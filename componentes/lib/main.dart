import 'package:flutter/material.dart';
import 'package:componentes/src/routes/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Componentes App',
      debugShowCheckedModeBanner: false,
      //home:HomePage(),
      initialRoute: '/',
      routes: getAplicationRoutes(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales:[
        const Locale('es','ES'),
        const Locale('en','US'),
      ] ,
      //onGenerateRoute: ( settings ){
          // print('Ruta llamda ${settings.name}');
          // return MaterialPageRoute(
          //   builder: (BuildContext context) => CardPage()
          // );
      //},
    );
  }
}