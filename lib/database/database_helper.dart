import 'dart:async';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:celaya_go/models/markers_model.dart';

class DatabaseHelper {
  static final nameDB = 'Markers';
  static final versionDB = 1;

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    return _database = await _initDatabase();
  }

  Future<Database?> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String pathDB = join(documentsDirectory.path, nameDB);

    return openDatabase(pathDB, version: versionDB, onCreate: _createTables);
  }

  //se debe acomodar la base de datos
  FutureOr<void> _createTables(Database db, int version) {
    String query = '''
      CREATE TABLE markers(
        id INTEGER PRIMARY KEY,
        latitude TEXT,
        longitude TEXT,
        title TEXT
      )
    ''';
    db.execute(query);
  }

  Future<int> INSERT(String tblName, MarkerModel markerData) async {
    var conexion = await database;
    return conexion!.insert(tblName, markerData.toMap());
  }

  Future<int> DELETE(String tblName, String field, int objectId, String? childTable) async {
    var connection = await database;
    if (childTable != null) {
      final dependentRows = await connection!
          .rawQuery("select * from $childTable where $field = $objectId");
      if (dependentRows.isEmpty) {
        return connection
            .delete(tblName, where: '$field = ?', whereArgs: [objectId]);
      } else {
        return 0;
      }
    } else {
      return connection!
          .delete(tblName, where: '$field = ?', whereArgs: [objectId]);
    }
  }
  Future<void> deleteMarker(int id) async {
    final db = await database;
    await db!.delete('markers', where: 'id = ?', whereArgs: [id]);
  }
  Future<List<MarkerModel>> getMarkers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.query('markers');
    return List.generate(maps.length, (i) {
      return MarkerModel.fromMap(maps[i]);
    });
  }
  Future<void> updateMarker(Map<String, dynamic> updatedMarker) async {
    final db = await database;
    await db!.update('markers', updatedMarker,
        where: 'id = ?', whereArgs: [updatedMarker['id']]);
  }
}