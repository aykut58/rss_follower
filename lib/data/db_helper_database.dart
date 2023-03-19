// ignore_for_file: avoid_print

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import '../models/rss_model.dart';
class DbHelperDatabase 
{
  final dbName = "/Rss_Database.db";

  final dbVersion = 2;

  final tableName ="Rss_Sources";

  final columnId = 'id';
  final columnTitle = "title";
  final columnnUrl = "url";

  static final DbHelperDatabase instance = DbHelperDatabase._init();
  static Database? _database;
  DbHelperDatabase._init();

  Future<Database> get database async 
  {
    if(_database != null ) return _database!;
    _database ??= await _initDb();
    return _database!;
  }

    Future <Database> _initDb() async 
  {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + dbName;
    var kagithaneDb = await openDatabase(path , version: dbVersion , onCreate: _createDb );
    return kagithaneDb;
  }

    Future _createDb (Database db , int version) async 
  {
    // ignore: unused_local_variable
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    // ignore: unused_local_variable
    // const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
      
      CREATE TABLE $tableName ($columnId $idType , $columnTitle $integerType , $columnnUrl $integerType)
      
      ''',
);
  }

    Future<int> insert(RssModel rssModel) async 
  {
    final db = await instance.database;
    final result = await db.insert(
      tableName, 
      rssModel.toMap(), 
      );
    return result;
  }

    /// [9]: Tüm Kayıtları liste halinde döndürür
  Future<List<RssModel>> getTodoList() async {
    final db = await instance.database;

    /// Veritabanı tablosundaki kayıtların tümünü al/getir
    final query = await db.query(tableName);

    /// Kayıtları Map'den Dart nesnelerine Iterable olarak dönüştür
    var map = query.map((json) => RssModel.fromMap(json));

    /// Iterable'ı List haline dönüştür.
    final result = map.toList();
    debugPrint(' Rss List result: $result');
    return result;
  }


   /// [7]: KAYDI SİL
  /// Silinen kaydın [id]'sini döndürür.
  Future<int> delete(int id) async {
    final db = await instance.database;
    final result = await db.delete(
      tableName,
      where: '$columnId = ?',
      whereArgs: [id],
    );
    // int count =await db.rawDelete("Delete From  $tableName Where id=$id");
    print(tableName.toString());
    print(columnId.toString());
    print(id);
   
    return result;
  }
  
Future<bool> isDataExist(String data) async {
  final db = await instance.database;
  final List<Map<String, dynamic>> maps = await db.query(tableName, where: "$columnTitle = ?", whereArgs: [data]);

  if (maps.length > 0) {
    return true;
  } else {
    return false;
  }
}
Future<bool> rssControl(String rssLink) async {
  final db = await instance.database;
  final count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $tableName WHERE $columnnUrl = ?', [rssLink]));
  if(count == 0) 
  {
    return true;
  }
  else
  {
    return false;
  }
}
}