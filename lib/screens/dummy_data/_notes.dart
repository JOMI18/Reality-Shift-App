import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reality_shift/imports.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  TextEditingController textCt = TextEditingController();

  List<Folder> rootFolders = [
    Folder(name: "Quick Notes", dateAdded: DateTime.now(), route: "all_notes"),

    // {"folder": "Quick Notes", "number": "120", "route": "all_notes"},
  ];

  void _editFolder(Folder folder) {
    textCt.text = folder.name;
    CreateNew.showFolderDialog(
      context,
      name: 'Edit Folder Name',
      hint: 'Enter new folder name',
      inputCt: textCt,
      first_action: "Save",
      onpressed: () {
        String newName = textCt.text;
        if (newName == "") return;

        setState(() {
          folder.name = newName;
          // shouldnt change edit time should be set
          folder.dateAdded = DateTime.now(); // Update date to reflect the edit
        });

        Navigator.of(context).pop();
      },
    );
  }

  void _createNewFolder([Folder? parentFolder]) {
    textCt.text = "";
    CreateNew.showFolderDialog(
      context,
      name: 'Create New Folder',
      hint: 'Enter folder name',
      inputCt: textCt,
      first_action: "Create",
      onpressed: () {
        // verify in back end first
        String folderName = textCt.text;
        if (folderName == "") return;
        setState(() {
          Folder newFolder = Folder(
            name: folderName,
            dateAdded: DateTime.now(),
          );
          if (parentFolder != null) {
            parentFolder.subFolders.add(newFolder);
          } else {
            rootFolders.add(newFolder);
          }
          // folder.add({"folder": folderName, "number": "", "route": ""});
        });

        Navigator.of(context).pop();
      },
    );
  }

  void _addQuickNote() {
    textCt.text = "";
    // CreateNew.showFolderDialog(
    //   context,
    //   name: 'Add Quick Note',
    //   hint: 'Enter note content',
    //   inputCt: textCt,
    //   first_action: "Add",
    //   onpressed: () {
    //     String noteContent = textCt.text;
    //     if (noteContent == "") return;

    //     setState(() {
    //       Folder quickNotesFolder = rootFolders
    //           .firstWhere((folder) => folder.name == "Quick Notes", orElse: () {
    //         // Create new "Quick Notes" folder if it doesn't exist
    //         Folder newFolder =
    //             Folder(name: "Quick Notes", dateAdded: DateTime.now());
    //         rootFolders.add(newFolder);
    //         return newFolder;
    //       });
    //       quickNotesFolder.notes.add(noteContent);
    //     });

    //     Navigator.of(context).pop();
    //   },
    // );
  }

  void _sortFolders() {
    setState(() {
      rootFolders.sort((a, b) => b.dateAdded.compareTo(a.dateAdded));
    });
  }

  // add folder functionality will push into
  @override
  Widget build(BuildContext context) {
    Color secondary = Utilities().appColors(context).secondary;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        floatingActionButton: SpeedDial(
          // overlayColor: CupertinoColors.activeBlue,
          overlayColor: Colors.black, // Set the overlay color
          overlayOpacity: 0.5, // Set the overlay opacity
          animatedIcon: AnimatedIcons.menu_close,
          children: [
            SpeedDialChild(
                child: const Icon(Icons.add),
                label: 'Add Folder',
                labelStyle: const TextStyle(color: Colors.black),
                onTap: _createNewFolder),
            SpeedDialChild(
              child: const Icon(Icons.edit_square),
              label: 'Add Quick Note',
              labelStyle: const TextStyle(color: Colors.black),
              onTap: _addQuickNote,
            ),
            SpeedDialChild(
              child: const Icon(Icons.sort),
              label: 'Sort Folders',
              labelStyle: const TextStyle(color: Colors.black),
              onTap: _sortFolders,
            ),
            // SpeedDialChild(
            //   child: const Icon(Icons.delete),
            //   label: 'Delete Folder',
            //   labelStyle: const TextStyle(color: Colors.black),
            //   onTap: () {
            //     // Add your delete note functionality here
            //   },
            // ),
            // SpeedDialChild(
            //   child: const Icon(Icons.edit),
            //   label: 'Edit Folder',
            //   labelStyle: const TextStyle(color: Colors.black),
            //   onTap: () {
            //     // Add your edit note functionality here
            //   },
            // ),
          ],
        ),
        appBar: CustomAppBar().welcomebar(context, "My Memo Pad:"),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                ComponentSlideIns(
                  beginOffset: const Offset(2, 0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Folders".toUpperCase(),
                            style: TextStyle(
                              fontSize: 20.sp,
                              color: secondary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.auto_awesome_motion_sharp,
                            color: secondary,
                            size: 25,
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(12.w, 8, 0, 4),
                        child: Divider(
                          height: 2,
                          thickness: 4,
                          color: secondary,
                        ),
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     GestureDetector(
                      //       onTap: () {
                      //         _createNewFolder();
                      //       },
                      //       child: Icon(
                      //         Icons.create_new_folder_rounded,
                      //         color: secondary,
                      //         size: 26,
                      //       ),
                      //     ),
                      //     Icon(
                      //       Icons.edit_square,
                      //       color: secondary,
                      //     )
                      //   ],
                      // ),
                    ],
                  ),
                ),
                ComponentSlideIns(
                  beginOffset: const Offset(-2, 0),
                  child: CustomTextField.input(context,
                      hint: "Search",
                      prefixIcon: Icon(
                        Icons.search,
                        color: secondary,
                      ),
                      suffixIcon: Icon(
                        Icons.mic,
                        color: secondary,
                      )),
                ),
                SizedBox(
                  height: 4.h,
                ),
                ComponentSlideIns(
                  beginOffset: const Offset(2, 0),
                  child: Card(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: rootFolders.length,
                        itemBuilder: (context, index) {
                          final folder = rootFolders[index];
                          print(folder.route);
                          return Column(
                            children: [
                              // CupertinoListSection.insetGrouped(
                              //   children: [
                              //     CupertinoListTile(title: Text("title"))
                              //   ],
                              // ),
                              CustomFolderWidget(
                                folder: folder,
                                onAddSubFolder: _createNewFolder,
                                onAddNote: (parentFolder, noteContent) {
                                  setState(() {
                                    parentFolder.notes.add(noteContent);
                                  });
                                },
                                onEditFolder: _editFolder,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Divider(
                                  height: 6,
                                  thickness: 0.5,
                                  color: index != rootFolders.length - 1
                                      ? Colors.black
                                      : Colors.transparent,
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
