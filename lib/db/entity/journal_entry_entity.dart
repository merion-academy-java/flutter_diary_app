import 'package:uuid/uuid.dart';

class JournalEntryEntity {
  String id;
  String date;
  String post;

  static const dbFileName = "journal.db";
  static const table = "journal_entry_entity";
  static const createDB = 'CREATE TABLE $table('
      'id TEXT PRIMARY KEY,'
      'date TEXT,'
      'post TEXT'
      ')';

  JournalEntryEntity()
      : id = const Uuid().v4(),
        date = DateTime.now().toString(),
        post = "";

  JournalEntryEntity.of(
      {required this.id, required this.date, required this.post});

  JournalEntryEntity.copy({required JournalEntryEntity obj})
      : id = obj.id,
        date = obj.date,
        post = obj.post;

  @override
  String toString() {
    return 'JournalEntryEntity{id: $id, date: $date, post: $post}';
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'date': date,
      'post': post
    };
  }

}
