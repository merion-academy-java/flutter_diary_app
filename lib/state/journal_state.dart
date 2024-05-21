import 'package:flutter/widgets.dart';
import 'package:flutter_diary_app/db/entity/journal_entry_entity.dart';
import 'package:flutter_diary_app/db/service/db_service.dart';
import 'package:intl/intl.dart';

class JournalState extends ChangeNotifier {
  List<JournalEntryEntity> journal = [];

  Future<JournalEntryEntity> create() async {
    JournalEntryEntity journalEntryEntity = JournalEntryEntity();
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd MMM yyyy').format(now);
    journalEntryEntity.date = formattedDate;
    journalEntryEntity.post = 'my thoughts';
    await DBService.instance().add(journalEntryEntity);
    journal.add(journalEntryEntity);
    notifyListeners();
    return journalEntryEntity;
  }

  void edit(JournalEntryEntity journalEntryEntity) async {
    for(int i = 0; i<journal.length;i++){
      if(journal[i].id == journalEntryEntity.id){
        journal[i] = journalEntryEntity;
        await DBService.instance().edit(journalEntryEntity);
        notifyListeners();
        return;
      }
    }
  }

  JournalEntryEntity? byId(String id) {
    for(int i = 0; i<journal.length;i++){
      if(journal[i].id == id){
        return journal[i];
      }
    }

    return null;
  }

  void load() async {
    List<JournalEntryEntity> all = await DBService.instance().list();
    journal.clear();
    journal.addAll(all);
    notifyListeners();
  }
}
