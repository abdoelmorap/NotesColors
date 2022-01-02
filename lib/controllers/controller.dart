import 'dart:async';

import 'package:abdelrhman_khaled_portfolio/db/dbschima.dart';
import 'package:abdelrhman_khaled_portfolio/models/model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NoteExampleDataBase {
  static final NoteExampleDataBase instance = NoteExampleDataBase._init();
  static Database? _database;
  NoteExampleDataBase._init();
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _init('note.db');
      return _database;
    }
  }

  Future<Database> _init(String s) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, s);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async => await db.execute('''
    Create TABLE ${TableNAME.tableName} (
    ${NotefIelds.id} ${NotefIeldsTypes.id} ,
    ${NotefIelds.title} ${NotefIeldsTypes.title} ,
    ${NotefIelds.number} ${NotefIeldsTypes.number} ,
    ${NotefIelds.createdTime} ${NotefIeldsTypes.createdTime} ,
    ${NotefIelds.descp} ${NotefIeldsTypes.descp} ,
    ${NotefIelds.isImportent} ${NotefIeldsTypes.isImportent} ,
    ${NotefIelds.slctDelete} ${NotefIeldsTypes.isImportent}    
   
    )
    ''');
  Future<Notes?> addNote(Notes note) async {
    final db = await instance.database;
    final id = await db!.insert(TableNAME.tableName, note.tojson());
    return note.copy(id: id);
  }

  Future<Notes?> readNote(String id) async {
    final db = await instance.database;
    final map = await db!.query(TableNAME.tableName,
        columns: NotefIelds.columns,
        where: '${NotefIelds.id} = ?',
        whereArgs: [id]);
    if (map.isNotEmpty) {
      return Notes.fromjson(map.first);
    } else {
      throw Exception("ID NOT FOUND");
    }
  }

  Future<List<Notes>?> readAllNotes() async {
    final db = await instance.database;
    final map = await db!.query(TableNAME.tableName,
        columns: NotefIelds.columns, orderBy: NotefIelds.orderBY);
    if (map.isNotEmpty) {
      return map.map((json) => Notes.fromjson(json)).toList();
    } else {
      throw Exception("ID NOT FOUND");
    }
  }

  Future<Notes?> updateNote(Notes note) async {
    final db = await instance.database;
    final id = await db!.update(TableNAME.tableName, note.tojson(),
        where: '${NotefIelds.id} = ?', whereArgs: [note.id]);
    return note.copy(id: id);
  }

  Future<int> delete(int? id) async {
    final db = await instance.database;
    return db!.delete(TableNAME.tableName,
        where: '${NotefIelds.id} = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db!.close();
  }
}
