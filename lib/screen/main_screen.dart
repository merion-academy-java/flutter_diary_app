import 'package:flutter/material.dart';
import 'package:flutter_diary_app/components/post_item_widget.dart';
import 'package:flutter_diary_app/db/entity/journal_entry_entity.dart';
import 'package:flutter_diary_app/state/journal_state.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(245, 245, 230, 1),
        title: const Text(
          'Journal',
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 36),
        ),
      ),
      body: Container(
        color: const Color.fromRGBO(245, 245, 230, 1),
        width: double.infinity,
        child: Consumer<JournalState>(
          builder: (context, state, child) {
            return ListView.builder(
                itemCount: state.journal.length + 1,
                itemBuilder: (context, index) {
                  if (index == state.journal.length) {
                    return const SizedBox(
                      height: 100,
                      width: 1,
                    );
                  }
                  return PostItemWidget(
                    journalEntryEntity: state.journal[index],
                  );
                });
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          JournalState state =
              Provider.of<JournalState>(context, listen: false);
          JournalEntryEntity journalEntryEntity = await state.create();
          if (context.mounted) {
            context.push('/edit/${journalEntryEntity.id}');
          }
        },
        tooltip: 'add',
        backgroundColor: Colors.blueAccent,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
