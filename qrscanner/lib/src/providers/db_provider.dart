
import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import 'package:qrscanner/src/models/scan_model.dart';
export 'package:qrscanner/src/models/scan_model.dart';


class DBProvider {

  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {

    if(_database != null) return _database;
    
    _database = await initDB();

    return _database;

  }

  //INICIALIZAR DB
  initDB() async {

    Directory documentDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentDirectory.path, 'ScansDB.db');

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db){},
      onCreate: ( Database db,int version ) async {

        await db.execute(
          'CREATE TABLE Scans ('
          ' id INTEGER PRIMARY KEY,'
          ' tipo TEXT ,'
          ' valor TEXT'
          ')'
        );

      }
    );

  }

  // CREAR REGISTROS
  
    //ANTIGUA
  Future<int> nuevoScanRaw(ScanModel nuevoScan) async{

    final db = await database;

    final res = await db.rawInsert(
      "INSERT INTO Scans (id,tipo,valor) "
      "VALUES (${nuevoScan.id},'${nuevoScan.tipo}','${nuevoScan.valor}')"
    );
    
    return res;
  }

    //NUEVA Y SEGURA
  Future<int> nuevoScan( ScanModel nuevoScan ) async {

    final db = await database;

    final res = await db.insert('Scans', nuevoScan.toJson() );

    return res;

  }

  // OBTENER REGISTROS

    // FILTRO POR ID
  Future<ScanModel> getScanId( int id ) async {

    final db = await database;

    final res = await db.query('Scans', where:'id = ?', whereArgs: [ id ]  );

    return res.isNotEmpty ? ScanModel.fromJson(res.first): null;

  }

    // OBTENER TODOS
  Future<List<ScanModel>> getTodosScans() async {

      final db = await database;

      final res = await db.query('Scans');

      List<ScanModel> list = res.isNotEmpty ? res.map( (c) => ScanModel.fromJson(c) ).toList() : [];

      return list;
  }

    // OBTENER POR TIPO
  Future<List<ScanModel>> getScansTipo( String tipo ) async {

      final db = await database;

      final res = await db.rawQuery("SELECT * FROM Scans WHERE  tipo  = '${tipo}'");

      List<ScanModel> list = res.isNotEmpty ? res.map( (c) => ScanModel.fromJson(c) ).toList() : [];

      return list;
  }

  // ACTUALIZAR 

  Future<int> updateScan( ScanModel nuevoScan) async {

    final db = await database;

    final res = await db.update('Scans', nuevoScan.toJson(), where: ' id = ? ', whereArgs: [ nuevoScan.id ]);

    return res;

  }

  // BORRAR REGISTROS

  Future<int> deleteScan( int id ) async {

    final db = await database;

    final res = await db.delete('Scans', where: 'id = ? ' , whereArgs: [id] );

    return res ;

  }

  Future<int> deleteAll() async {

    final db = await database;

    final res = await db.rawDelete('DELETE FROM Scans ');

    return res ;

  }


}