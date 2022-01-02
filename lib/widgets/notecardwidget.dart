import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/model.dart';

final _lightColors = [
  Colors.amber.shade600,
  Colors.amber.shade300,
  Colors.lightGreen.shade300,
  Colors.lightBlue.shade300,
  Colors.orange.shade300,
  Colors.pinkAccent.shade100,
  Colors.tealAccent.shade100,
  Colors.lightGreen.shade700,
  Colors.lightBlue.shade300,
  Colors.orange.shade500,
  Colors.pinkAccent.shade700,
  Colors.tealAccent.shade400
];

class NoteCardWidget extends StatelessWidget {
  const NoteCardWidget(
      {Key? key,
      required this.note,
      required this.index,
      required this.onstarClick})
      : super(key: key);

  final Notes note;
  final int index;
  final VoidCallback onstarClick;

  @override
  Widget build(BuildContext context) {
    /// Pick colors from the accent colors based on index
    final color = _lightColors[index % _lightColors.length];
    final time = DateFormat.yMMMd().format(note.createdTime);
    final minHeight = getMinHeight(index);

    return Card(
        color: color,
        child: Container(
          padding: const EdgeInsets.all(8),
          constraints: BoxConstraints(minHeight: minHeight),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    children: [
                      Text(
                        time,
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      GestureDetector(
                          child: Icon(
                            Icons.star,
                            color:
                                note.isImportent ? Colors.amber : Colors.grey,
                          ),
                          onTap: () {
                            onstarClick();
                          })
                    ],
                  )),
              const SizedBox(height: 4),
              Text(
                note.title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ));
  }

  /// To return different height for different widgets
  double getMinHeight(int index) {
    switch (index % 4) {
      case 0:
        return 100;
      case 1:
        return 150;
      case 2:
        return 150;
      case 3:
        return 100;
      default:
        return 100;
    }
  }
}
