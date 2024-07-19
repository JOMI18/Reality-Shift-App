import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reality_shift/imports.dart';

class NoteData extends ChangeNotifier {
// overall list of notes

  List<Note> allNotes = [
    // default first note

    Note(
      id: 0,
      title: "Northern Lights",
      dateEdited: "",
      text:
          "Visit the northern lights with your brother, also remember to bring your polaroid with you ",
      dateCreated: DateFormat('MM/dd/yyyy')
          .format(DateTime.now().subtract(const Duration(days: 250))),
    ),
    Note(
        id: 1,
        title: "Fashion in Korea",
        dateEdited: "",
        text:
            "Buy this Jacket for me and pam, Visit the northern lights with your brother, also remember to bring your polaroid with you ,Visit the northern lights with your brother, also remember to bring your polaroid with you ,Visit the northern lights with your brother, also remember to bring your polaroid with you ",
        dateCreated: DateFormat('MM/dd/yyyy')
            .format(DateTime.now().subtract(const Duration(days: 50))))
  ];

  // get note
  List<Note> getAllNotes() {
    return allNotes;
  }

  // add a new note
  void addNewNote(Note note) {
    allNotes.add(note);
    notifyListeners();
  }

  // Update note
  void updateNote(Note note, String? title, String text) {
    // go through list of all notes

    // for (var element in allNotes) {
    //   print(element);
    // }

    for (int i = 0; i < allNotes.length; i++) {
      if (allNotes[i].id == note.id) {
        allNotes[i].title = title!;
        allNotes[i].text = text;
        allNotes[i].dateEdited =
            DateFormat('MM/dd/yyyy').format(DateTime.now());
        break;
      }
    }
    notifyListeners();
  }

  // delete note
  void deleteNote(Note note) {
    allNotes.remove(note);
    notifyListeners();
  }
}
