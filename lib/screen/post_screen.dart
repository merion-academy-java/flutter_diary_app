import 'package:flutter/material.dart';
import 'package:flutter_diary_app/db/entity/journal_entry_entity.dart';
import 'package:flutter_diary_app/state/journal_state.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key, required this.id});

  final String id;

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  JournalEntryEntity? _journalEntryEntity;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        JournalState state = Provider.of<JournalState>(context, listen: false);
        _journalEntryEntity = state.byId(widget.id);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(245, 245, 230, 1),
        title: Text(
          _journalEntryEntity?.date ?? 'loading',
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 36),
        ),
      ),
      body: Container(
        color: const Color.fromRGBO(245, 245, 230, 1),
        width: double.infinity,
        child: Container(
            width: double.infinity,
            height: double.infinity,
            padding:
                const EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 82),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: _journalEntryEntity != null ? TextFormField(
                maxLines: null,
                initialValue: _journalEntryEntity?.post ?? '',
                onChanged: (value) {
                  setState(() {
                    _journalEntryEntity?.post = value;
                  });
                },

                keyboardType: TextInputType.multiline,
                //or null
                decoration: const InputDecoration.collapsed(
                    hintText: "Enter your text here"),
              ) : Container(),
            )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (context.mounted && _journalEntryEntity != null) {
            JournalState state =
                Provider.of<JournalState>(context, listen: false);
            state.edit(_journalEntryEntity!);
            context.pop();
          }
        },
        tooltip: 'save',
        backgroundColor: Colors.blueAccent,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.save,
          color: Colors.white,
        ),
      ),
    );
  }
}
