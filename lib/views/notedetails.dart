import 'package:abdelrhman_khaled_portfolio/models/model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../controllers/controller.dart';

class NoteDetails extends StatefulWidget {
  const NoteDetails({Key? key, required this.notes}) : super(key: key);

  final Notes notes;

  @override
  State<NoteDetails> createState() => _NoteDetailsState();
}

class _NoteDetailsState extends State<NoteDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.white,
        appBar: AppBar(
          //for gradient Theme
          // flexibleSpace: Container(
          //   decoration: const BoxDecoration(
          //     gradient: LinearGradient(
          //       begin: Alignment.centerLeft,
          //       end: Alignment.centerRight,
          //       colors: <Color>[Colors.red, Colors.blue],
          //     ),
          //   ),
          // ),
          title: Text(
            widget.notes.title,
            style: const TextStyle(fontSize: 24),
          ),
          actions: [
            GestureDetector(
              child: const Icon(Icons.edit),
              onTap: () async {
                showDialog<void>(
                    context: context,
                    barrierDismissible: false, // user must tap button!
                    builder: (BuildContext context) {
                      TextEditingController _ctrlTextMate =
                          TextEditingController();
                      TextEditingController _ctrlTextiles =
                          TextEditingController();
                      _ctrlTextMate.text = widget.notes.title;
                      _ctrlTextiles.text = widget.notes.descp;
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
                              await NoteExampleDataBase.instance.updateNote(
                                  Notes(
                                      title: _ctrlTextMate.text,
                                      createdTime: widget.notes.createdTime,
                                      descp: _ctrlTextiles.text,
                                      isImportent: widget.notes.isImportent,
                                      slctDelete: widget.notes.slctDelete,
                                      number: 1,
                                      id: widget.notes.id));
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
              },
            ),
            const SizedBox(width: 12),
            GestureDetector(
                child: const Icon(Icons.delete),
                onTap: () {
                  showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('New Note'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: const <Widget>[
                                Text(
                                    'Are You Sure You want to delete this  Note?'),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Confirm'),
                              onPressed: () async {
                                await NoteExampleDataBase.instance
                                    .delete(widget.notes.id);

                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      });
                }),
            const SizedBox(width: 12),
          ],
        ),
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  //for gradient Theme

                  // gradient: const LinearGradient(
                  //     colors: [
                  //       Color(0xFF7C3784),
                  //       Color(0xFF335FFF),
                  //     ],
                  //     begin: FractionalOffset(0.0, 0.0),
                  //     end: FractionalOffset(1.0, 0.0),
                  //     stops: [0.0, 1.0],
                  //     tileMode: TileMode.clamp),
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: Column(
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        widget.notes.title,
                        style: const TextStyle(fontSize: 38),
                        textAlign: TextAlign.right,
                      )),
                  Container(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.lightBlue,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        child: Text(
                          DateFormat.yMMMd().format(widget.notes.createdTime),
                          textAlign: TextAlign.right,
                        ),
                      )),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.fromLTRB(25, 140, 25, 30),
              decoration: BoxDecoration(
                  //for gradient Theme

                  // gradient: const LinearGradient(
                  //     colors: [
                  //       Color(0xFF335FFF),
                  //       Color(0xFF7C3784),
                  //     ],
                  //     begin: FractionalOffset(0.0, 0.0),
                  //     end: FractionalOffset(1.0, 0.0),
                  //     stops: [0.0, 1.0],
                  //     tileMode: TileMode.clamp),
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: Center(
                  child: Text(
                widget.notes.descp,
                style: const TextStyle(fontSize: 19),
              )),
            )
          ],
        ));
  }
}
