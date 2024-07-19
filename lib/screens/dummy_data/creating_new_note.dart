// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:reality_shift/imports.dart';

// class CreateNewNote extends StatefulWidget {
//   Note? note;
//   bool? isNewNote;

//   CreateNewNote({super.key, this.note, this.isNewNote});

//   @override
//   State<CreateNewNote> createState() => _CreateNewNoteState();
// }

// class _CreateNewNoteState extends State<CreateNewNote> {
//   QuillController _controller = QuillController.basic();

//   @override
//   void initState() {
//     super.initState();
//     loadExistingNote();
//   }

// // load existing note

//   loadExistingNote() {
//     final doc = Document()..insert(0, widget.note?.text);
//     setState(() {
//       _controller = QuillController(
//           document: doc, selection: const TextSelection.collapsed(offset: 0));
//     });
//   }

// // add new note,

//   void addNewNote(int id, ref) {
//     final noteData = ref.read(NotesProvider.notifier).state;
//     String text = _controller.document.toPlainText();

//     final newNote = Note(
//       id: id,
//       title: "",
//       text: text,
//       dateCreated: DateFormat('MM/dd/yyyy').format(DateTime.now()),
//     );

//     setState(() {
//       noteData.addNewNote(newNote);
//     });
//   }

// // update existing note

//   void updateNote(ref) {
//     final noteData = ref.read(NotesProvider.notifier).state;

//     // get text from editor
//     String text = _controller.document.toPlainText();
//     noteData.updateNote(widget.note, text);

// // update note
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               // QuillToolbar.basic(
//               //   controller:_controller
//               // ),

//               // TextField(
//               //   // controller: _titleController,
//               //   decoration: InputDecoration(
//               //     labelText: 'Title',
//               //   ),
//               // ),
//               // Expanded(
//               //   // child: quill.QuillEditor.basic(
//               //   //   controller: _controller,
//               //   //   readOnly: false,
//               //   // ),
//               // ),
//             ],
//           )),
//     );
//   }
// }
