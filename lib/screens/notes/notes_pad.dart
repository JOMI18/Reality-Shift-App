import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reality_shift/imports.dart';

class NotesPad extends StatefulWidget {
  const NotesPad({super.key});

  @override
  State<NotesPad> createState() => _NotesPadState();
}

class _NotesPadState extends State<NotesPad> {
  TextEditingController titleCt = TextEditingController();
  TextEditingController bodyCt = TextEditingController();
  // Track the expanded state of notes
  int? expandedNoteIndex;

  // create new note
  void createNewNote(ref, primary) {
    final noteData = ref.read(NotesProvider.notifier).state;
    // print(noteData);

    // create new id
    int id = noteData.getAllNotes().length;

    // create bottom sheet
    popBottomSheetUp(noteData, id, primary);
  }

  // Show bottom sheet for creating or editing note
  void popBottomSheetUp(noteData, id, primary) {
    final content = Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomTextField.input(
            context,
            controller: titleCt,
            fieldname: "Name of Note",
          ),
          SizedBox(
            height: 2.h,
          ),
          CustomTextField.dialogBox(
            context,
            controller: bodyCt,
            fieldname: "What I need to remember",
          ),
          SizedBox(
            height: 2.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Btns().shortBtn(context, "Edit Note", () {
                if (titleCt.text == "" || bodyCt.text == "") return;
                setState(() {
                  final currNote = Note(
                    id: id,
                    title: titleCt.text,
                    text: bodyCt.text,
                    dateCreated: "",
                  );
                  noteData.updateNote(
                    currNote,
                    currNote.title,
                    currNote.text,
                  );
                  titleCt.clear();
                  bodyCt.clear();

                  Navigator.pop(context);
                });
              }),
              Btns().shortBtn(context, "Create Note", () {
                if (titleCt.text == "" || bodyCt.text == "") return;
                setState(() {
                  final newNote = Note(
                    id: id,
                    title: titleCt.text,
                    text: bodyCt.text,
                    dateCreated:
                        DateFormat('MM/dd/yyyy').format(DateTime.now()),
                  );
                  noteData.addNewNote(newNote);
                  titleCt.clear();
                  bodyCt.clear();

                  Navigator.pop(context);
                });
              })
            ],
          )
        ],
      ),
    );
    return CustomBottomSheet.showContent(context, content, 65.h,
        color: primary);
  }

  // delete note
  void _deleteNote(Note note, ref) {
    final noteData = ref.read(NotesProvider.notifier).state;
    noteData.deleteNote(note);
  }

  // edit note
  void _editNote(Note note, ref, primary) {
    final noteData = ref.read(NotesProvider.notifier).state;
    print(noteData);

    titleCt.text = note.title;
    bodyCt.text = note.text;
    final id = note.id;
    popBottomSheetUp(noteData, id, primary);
  }

  Widget build(BuildContext context) {
    Color secondary = Utilities().appColors(context).secondary;
    Color primary = Utilities().appColors(context).primary;
    return Consumer(
      builder: (context, ref, _) {
        final selectedTheme = ref.watch(AppThemeProvider)["theme"];
        Color colorbgWhite = selectedTheme == darkTheme
            ? Colors.teal.withOpacity(0.6)
            : secondary.withOpacity(0.6);
        final note = ref.watch(NotesProvider);
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              createNewNote(ref, primary);
            },
            child: const Icon(Icons.add),
          ),
          appBar: CustomAppBar().welcomebar(context, "My Memo Pad:"),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  ComponentSlideIns(
                    beginOffset: const Offset(2, 0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Flexible(
                              child: Text(
                                "Inside Psalms of Oluwajomiloju ".toUpperCase(),
                                softWrap: true,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  overflow: TextOverflow.visible,
                                  color: secondary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Icon(
                              Icons.auto_awesome_motion_sharp,
                              color: secondary,
                              size: 25,
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(12.w, 8, 0, 4.h),
                          child: Divider(
                            height: 2,
                            thickness: 4,
                            color: secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                      children:
                          List.generate(note.getAllNotes().length, (index) {
                    final item = note.getAllNotes()[index];
                    final title = item.title;
                    final date = item.dateCreated.toString();
                    // final date = item.dateEdited.toString();
                    final content = item.text;
                    bool isExpanded = expandedNoteIndex == index;

                    return Card(
                      color: Colors.black,
                      shape: const RoundedRectangleBorder(
                          side: const BorderSide(width: 2, color: Colors.teal),
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                              bottom: Radius.circular(15))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      "You added a note on: $title",
                                      softWrap: true,
                                      style: const TextStyle(
                                        height: 1.8,
                                        // letterSpacing: 1.02,
                                        fontWeight: FontWeight.w700,
                                        overflow: TextOverflow.visible,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        expandedNoteIndex =
                                            isExpanded ? null : index;
                                      });
                                    },
                                    child: Icon(
                                      isExpanded
                                          ? Icons.expand_less
                                          : Icons.expand_more,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            if (isExpanded)
                              Container(
                                width: 90.w,
                                // height: 35.h,
                                decoration: BoxDecoration(
                                    color: colorbgWhite,
                                    borderRadius: const BorderRadius.vertical(
                                        bottom: Radius.circular(6))),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        content,
                                        style: TextStyle(
                                          fontSize: 17.sp,
                                          color: const Color(0xFFF4F4F4),
                                        ),
                                      ),
                                      SizedBox(height: 2.h),
                                      Container(
                                        padding:
                                            EdgeInsets.fromLTRB(4, 5, 4, 4),
                                        decoration: const BoxDecoration(
                                          border: Border.fromBorderSide(
                                              BorderSide(width: 2)),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _editNote(item, ref, primary);
                                                });
                                              },
                                              child: const CircleAvatar(
                                                backgroundColor: Colors.white,
                                                child: Icon(
                                                  Icons.edit,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _deleteNote(item, ref);
                                                });
                                              },
                                              child: const CircleAvatar(
                                                backgroundColor: Colors.white,
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Date Created: $date",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  )),
                            )
                          ],
                        ),
                      ),
                    );
                  }))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
