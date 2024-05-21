import 'package:flutter/material.dart';
import 'package:flutter_diary_app/db/entity/journal_entry_entity.dart';
import 'package:go_router/go_router.dart';

class PostItemWidget extends StatelessWidget {
  const PostItemWidget({super.key, required this.journalEntryEntity});

  final JournalEntryEntity journalEntryEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: GestureDetector(

        onTap: (){
          context.push("/edit/${journalEntryEntity.id}");
        },

        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(journalEntryEntity.post, style: const TextStyle(
                  fontSize: 16
              ),),
              const SizedBox(height: 16,width: 1,),
              Container(
                color: const Color.fromRGBO(247, 247, 247, 1),
                width: double.infinity,
                height: 1,
              ),
              const SizedBox(height: 4,width: 1,),
              Text(journalEntryEntity.date, style: const TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.normal
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
