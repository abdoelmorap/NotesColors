import 'package:abdelrhman_khaled_portfolio/models/model.dart';
import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../controllers/controller.dart';
import '../widgets/notecardwidget.dart';
import 'package:vibration/vibration.dart';

import 'notedetails.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = false;
  late List<Notes> notes;

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  @override
  void dispose() {
    NoteExampleDataBase.instance.close();

    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    notes = (await NoteExampleDataBase.instance.readAllNotes())!;

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,

          title: const Text(
            'Notes',
            style: TextStyle(fontSize: 24),
          ),
          //  actions: [Icon(Icons.search), SizedBox(width: 12)],
        ),
        body: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : notes.isEmpty
                  ? const Text(
                      'No Notes',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    )
                  : buildNotes(),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: const Icon(
            Icons.add,
            color: Colors.grey,
          ),
          onPressed: () async {
            showDialog<void>(
              context: context,
              barrierDismissible: false, // user must tap button!
              builder: (BuildContext context) {
                TextEditingController _ctrlTextMate = TextEditingController();
                TextEditingController _ctrlTextiles = TextEditingController();

                return AlertDialog(
                  title: const Text('New Note'),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        const Text('What is going inside your mind?'),
                        TextField(
                          controller: _ctrlTextMate,
                          decoration: const InputDecoration(
                            hintText: 'Title',
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextField(
                          controller: _ctrlTextiles,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: const InputDecoration(
                            hintText: 'description',
                          ),
                        )
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Add'),
                      onPressed: () async {
                        await NoteExampleDataBase.instance.addNote(Notes(
                            title: _ctrlTextMate.text,
                            createdTime: DateTime.now(),
                            descp: _ctrlTextiles.text,
                            isImportent: true,
                            slctDelete: false,
                            number: 1,
                            id: null));
                        Navigator.of(context).pop();
                        refreshNotes();
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
      );

  Widget buildNotes() => MasonryGridView.count(
        padding: const EdgeInsets.all(8),
        itemCount: notes.length,
        crossAxisCount: 3,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        itemBuilder: (context, index) {
          final note = notes[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                    builder: (context) => NoteDetails(notes: note),
                  ))
                  .then((value) => refreshNotes());
            },
            child: ShakeAnimatedWidget(
              enabled: note.isImportent,
              duration: const Duration(milliseconds: 250),
              shakeAngle: Rotation.deg(z: 7),
              curve: Curves.linear,
              child: NoteCardWidget(
                note: note,
                index: index,
                onstarClick: () async {
                  await NoteExampleDataBase.instance.updateNote(Notes(
                      id: note.id,
                      title: note.title,
                      createdTime: note.createdTime,
                      descp: note.descp,
                      slctDelete: note.slctDelete,
                      isImportent: !note.isImportent,
                      number: note.number));

                  refreshNotes();
                  if (await Vibration.hasVibrator() != null ||
                      await Vibration.hasVibrator() != false) {
                    Vibration.vibrate();
                  }
                },
              ),
            ),
          );
        },
      );
}
