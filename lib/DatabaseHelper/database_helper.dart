import 'dart:async';
import 'dart:io';

import 'package:neostore/model/addressModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  final dbName = 'Address.db';
  final dbVersion = 1;
  final tableName = 'AddressDetail';
  final columnId = 'id';
  final columnAddress = 'address';
  final columncityLandMark = 'cityLandMark';
  final columnCity = 'city';
  final columnState = 'state';
  final columnzipCode = 'zipCode';
  final columnCountry = 'country';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;

  Future<Database> get databse async {
    if (_database != null) {
      return _database;
    } else {
      _database = await initDatabase();
      return _database;
    }
  }

  initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbName);
    return await openDatabase(path, onCreate: createTable, version: dbVersion);
  }

  Future<void> createTable(Database db, int version) {
    return db.execute('''
        CREATE TABLE $tableName ($columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnAddress TEXT,
        $columncityLandMark TEXT,
        $columnCity TEXT,
        $columnState Text,
        $columnzipCode INTEGER,
        $columnCountry TEXT
        
        )
        
        ''');
  }

  Future<int> insertAddress(AddressModel addressModel) async {
    try {
      Database db = await instance.databse;
      return await db.insert(tableName, addressModel.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      print('failed Inserting into table');
    }
  }

  Future<List<AddressModel>> getAddress() async {
    Database db = await instance.databse;
    final List<Map<String, dynamic>> getAllAddress = await db.query(tableName);
    return List.generate(getAllAddress.length, (index) {
      return AddressModel.fromMap({
        columnId: getAllAddress[index][columnId],
        columnAddress: getAllAddress[index][columnAddress],
        columncityLandMark: getAllAddress[index][columncityLandMark],
        columnCity: getAllAddress[index][columnCity],
        columnState: getAllAddress[index][columnState],
        columnzipCode: getAllAddress[index][columnzipCode],
        columnCountry: getAllAddress[index][columnCountry]
      });
    });
  }

  Future<int> deleteAddress(int id) async {
    Database db = await instance.databse;
    return await db.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }
}
