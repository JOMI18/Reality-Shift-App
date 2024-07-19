   // default

  // go to edit the note
  // goToNotePage(newNote, true);
  // List note = [
  //   {
  //     "title": "Fashion in Korea Fashion ",
  //     "content": "Buy this Jacket for me and pam",
  //     "date": DateFormat('MM/dd/yyyy')
  //         .format(DateTime.now().subtract(const Duration(days: 50))),
  //   },
  //   {
  //     "title": "Fashion in Korea",
  //     "content": "Buy this Jacket for me and pam",
  //     "date": DateFormat('MM/dd/yyyy').format(DateTime.now()),
  //   },
  // ];

  // void updateNoteTitle(Note note, String newTitle, ref) {
  //   final noteData = ref.read(NotesProvider.notifier);
  //   noteData.updateNote(note, newTitle, note.text);
  // }

  // void updateNoteContent(Note note, String newContent, ref) {
  //   final noteData = ref.read(NotesProvider.notifier);
  //   noteData.updateNote(note, note.title, newContent);
  // }


 // void goToNotePage(Note note, bool isNewNote) {
  //   Navigator.pushNamed(context, "new_note",
  //       arguments: {note: note, isNewNote: false});
  // }

  
  
  ////////////// Original
                  // Column(
                  //   children: note.getAllNotes().asMap().entries.map((entry) {
                  //     int index = entry.key;
                  //     var item = entry.value;
                  //     final title = item.title;
                  //     final date = item.dateCreated.toString();
                  //     final content = item.text;
                  //     bool isExpanded = expandedNoteIndex == index;
                  //     return Card(
                  //       color: Colors.black,
                  //       shape: const RoundedRectangleBorder(
                  //           side:
                  //               const BorderSide(width: 2, color: Colors.teal),
                  //           borderRadius: BorderRadius.vertical(
                  //               top: Radius.circular(20),
                  //               bottom: Radius.circular(15))),
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Padding(
                  //               padding: const EdgeInsets.all(8.0),
                  //               child: Row(
                  //                 mainAxisAlignment:
                  //                     MainAxisAlignment.spaceBetween,
                  //                 children: [
                  //                   Flexible(
                  //                     child: GestureDetector(
                  //                       onTap: () {
                  //                         _editTitle();
                  //                       },
                  //                       child: Text(
                  //                         "$title",
                  //                         softWrap: true,
                  //                         style: const TextStyle(
                  //                           height: 1.8,
                  //                           fontWeight: FontWeight.w700,
                  //                           overflow: TextOverflow.visible,
                  //                           color: Colors.white,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                   GestureDetector(
                  //                     onTap: () {
                  //                       setState(() {
                  //                         expandedNoteIndex =
                  //                             isExpanded ? null : index;
                  //                       });
                  //                     },
                  //                     child: Icon(
                  //                       isExpanded
                  //                           ? Icons.expand_less
                  //                           : Icons.expand_more,
                  //                       color: Colors.white,
                  //                     ),
                  //                   )
                  //                 ],
                  //               ),
                  //             ),
                  //             const SizedBox(
                  //               height: 10,
                  //             ),
                  //             if (isExpanded)
                  //               Container(
                  //                 width: 90.w,
                  //                 height: 35.h,
                  //                 decoration: BoxDecoration(
                  //                     color: colorbgWhite,
                  //                     borderRadius: const BorderRadius.vertical(
                  //                         bottom: Radius.circular(6))),
                  //                 child: Padding(
                  //                   padding: const EdgeInsets.all(8.0),
                  //                   child: Text(
                  //                     content,
                  //                     style: TextStyle(
                  //                       fontSize: 17.sp,
                  //                       color: const Color(0xFFF4F4F4),
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ),
                  //             Padding(
                  //               padding: const EdgeInsets.all(8.0),
                  //               child: Text("Date Created: $date",
                  //                   style: const TextStyle(
                  //                     fontWeight: FontWeight.w700,
                  //                     color: Colors.white,
                  //                   )),
                  //             )
                  //           ],
                  //         ),
                  //       ),
                  //     );
                  //   }).toList(),
                  // ),
              