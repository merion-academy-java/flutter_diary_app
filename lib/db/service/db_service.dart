import 'package:flutter_diary_app/db/entity/journal_entry_entity.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBService {
  late final Future<Database> database;
  static DBService? service;

  static DBService instance() {
    if (service == null) {
      service = DBService();
      // service!.init();
    }

    return service!;
  }

  Future<Database> init() async {
    database = openDatabase(
        join(await getDatabasesPath(), JournalEntryEntity.dbFileName),
        onCreate: (db, version) {
      return db.execute(JournalEntryEntity.createDB);
    }, version: 1);
    return database;
  }

  Future<void> add(JournalEntryEntity journalEntryEntity) async {
    final db = await database;
    await db.insert(JournalEntryEntity.table, journalEntryEntity.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<JournalEntryEntity>> list() async {
    final db = await database;
    final List<Map<String, Object?>> journal =
    await db.query(JournalEntryEntity.table);

    return [
      for (final {
      'id': id as String,
      'date': date as String,
      'post': post as String
      } in journal)
        JournalEntryEntity.of(id: id, date: date, post:post)
    ];
  }

  Future<void> edit(JournalEntryEntity journalEntryEntity) async {
    final db = await database;
    await db.update(
        JournalEntryEntity.table,
        journalEntryEntity.toMap(),
        where: 'id = ?',
        whereArgs: [journalEntryEntity.id]);
  }
}
