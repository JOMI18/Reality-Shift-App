import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reality_shift/imports.dart';

class MyFolders extends StatefulWidget {
  const MyFolders({super.key});

  @override
  State<MyFolders> createState() => _MyFoldersState();
}

class _MyFoldersState extends State<MyFolders> {
  bool doesSubFolderExist = false;
  bool isEditActive = false;
  bool isNoteBeingCreated = false;
  bool isCreateActionActive = false;
  TextEditingController textCt = TextEditingController();
  String? selectedItem;

  Widget showEditingIcon(Folder folder, FolderData folderData, String name) {
    return PopupMenuButton<String>(
      icon: const Icon(
        Icons.more_vert_rounded,
        color: Colors.yellow,
      ),
      onSelected: (item) {
        // print(item);
        setState(() {
          selectedItem = item;
        });
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        _buildPopupMenuItem("Rename", Icons.edit, Colors.teal, () {
          setState(() {
            isCreateActionActive = false;
          });
          _renameFolder(folder, folderData);
        }),
        _buildPopupMenuItem("New", Icons.create_new_folder_sharp, Colors.teal, () {
          _createSubFolder(folder, folderData);
        }),
        _buildPopupMenuItem("Share", Icons.ios_share_rounded, Colors.teal, null),
        _buildPopupMenuItem("Group by Date", Icons.calendar_month, Colors.teal, null, isGroupByDate: true),
        _buildPopupMenuItem("Delete", Icons.delete, Colors.red, () {
          _confirmDelete(folder, folderData);
        }, isDelete: true),
      ],
    );
  }

  void _confirmDelete(Folder folder, FolderData folderData) {
    AlertInfo alert = AlertInfo();

    alert.title = "Delete ${folder.name} FOLDER? ";
    alert.message = "Are you sure you want to delete this folder?";
    alert.showAlertDialog(context, func: () {
      folderData.deleteFolder(folder);
      Navigator.pop(context);
    }, name: "Yes");
  }

  PopupMenuItem<String> _buildPopupMenuItem(String title, IconData icon, Color iconColor, VoidCallback? onTap,
      {bool isDelete = false, bool isGroupByDate = false}) {
    return PopupMenuItem<String>(
      value: title,
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: iconColor),
          SizedBox(width: 2.w),
          Text(
            isGroupByDate ? title : "$title Folder",
            style: TextStyle(color: isDelete ? Colors.red : Colors.black),
          ),
        ],
      ),
    );
  }

  void _createFolder(FolderData folderData) {
    setState(() {
      isCreateActionActive = true;
    });
    int id = folderData.getAllFolders().length;
    showFolderDialog(id, folderData);
  }

  void _renameFolder(folder, folderData) {
    // print(folder.id);
    int id = folder.id;
    textCt.text = folder.name;
    showFolderDialog(id, folderData, folder: folder);
  }

  Future<String?> showFolderDialog(int id, FolderData folderData, {Folder? folder, Folder? parentFolder}) {
    return CreateNew.showFolderDialog(context,
        name: 'Create New Folder',
        hint: 'Enter folder name',
        inputCt: textCt,
        first_action: "Create",
        second_action: "Rename",
        option: isCreateActionActive
            ? null
            : () {
                // print(folderData);
                if (textCt.text == "") return;
                setState(() {
                  final currFold = Folder(
                    id: id,
                    name: textCt.text,
                    dateCreated: '',
                    content_number: 0,
                  );
                  folderData.renameFolder(currFold, currFold.name);
                  textCt.clear();
                  Navigator.pop(context);
                });
              },
        onpressed: isCreateActionActive
            ? () {
                if (textCt.text == "") return;
                setState(() {
                  final newFolder = Folder(
                    name: textCt.text,
                    id: id,
                    dateCreated: '',
                    route: '',
                    content_number: 0,
                  );

                  if (parentFolder != null) {
                    folderData.addSubFolders(parentFolder, newFolder);
                  } else {
                    folderData.addNewFolders(newFolder);
                  }
                  textCt.clear();
                  Navigator.of(context).pop();
                });
              }
            : null);
  }

  void _createSubFolder(parentFolder, folderData) {
    setState(() {
      isCreateActionActive = true;
    });
    int id = folderData.getAllFolders().length + parentFolder.subFolders.length;
    showFolderDialog(id, folderData, parentFolder: parentFolder);
  }

  @override
  Widget build(BuildContext context) {
    Color secondary = Utilities().appColors(context).secondary;
    Color primary = Utilities().appColors(context).primary;
    return Consumer(
      builder: (context, ref, _) {
        final folderData = ref.read(FolderProvider.notifier).state;
        final selectedTheme = ref.watch(AppThemeProvider)["theme"];
        Color transitionColor = selectedTheme == darkTheme ? secondary : primary;
        // final folderData = ref.watch(FolderProvider);
        return Scaffold(
          floatingActionButton: isNoteBeingCreated ? null : _buildSpeedDial(folderData),
          appBar: CustomAppBar().welcomebar(context, "My Memo Pad:"),
          body: isNoteBeingCreated
              // ? NotesPad(isNoteBeingCreated: isNoteBeingCreated)
              ? NotesPad(
                  isNoteBeingCreated: isNoteBeingCreated,
                  onBackArrowPressed: () {
                    setState(() {
                      isNoteBeingCreated = false;
                    });
                  },
                )
              // ? Navigator.pushNamed(context, "notes_pad", arguments: {isNoteBeingCreated: isNoteBeingCreated})
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 28, 12, 12.0),
                    child: Column(
                      children: [
                        ComponentSlideIns(
                          beginOffset: const Offset(2, 0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.folder_copy_rounded,
                                    color: secondary,
                                    size: 25,
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Flexible(
                                      child: Text("All Folders".toUpperCase(),
                                          softWrap: true,
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              fontSize: 20.sp,
                                              overflow: TextOverflow.visible,
                                              color: secondary,
                                              fontWeight: FontWeight.w900))),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        ComponentSlideIns(
                            beginOffset: const Offset(0, 3),
                            child: Column(
                              children: [
                                _buildFoldersList(folderData, transitionColor, secondary),
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }

  Widget _buildSpeedDial(FolderData folderData) {
    return SpeedDial(
      // overlayColor: CupertinoColors.activeBlue,
      overlayColor: Colors.black,
      overlayOpacity: 0.5,
      animatedIcon: AnimatedIcons.menu_close,
      children: [
        SpeedDialChild(
          child: const Icon(Icons.my_library_add),
          label: 'Create Folder',
          labelStyle: const TextStyle(color: Colors.black),
          onTap: () {
            _createFolder(folderData);
          },
        ),
        SpeedDialChild(
          child: const Icon(Icons.new_label_rounded),
          label: 'Create Note',
          labelStyle: const TextStyle(color: Colors.black),
          onTap: () {
            setState(() {
              isNoteBeingCreated = true;
            });
            // Navigator.pushNamed(context, "notes_pad");
          },
        ),
        SpeedDialChild(
          child: isEditActive ? const Icon(Icons.done_all_sharp) : const Icon(Icons.edit_square),
          label: isEditActive ? "Done" : 'Edit',
          labelStyle: const TextStyle(color: Colors.black),
          onTap: () {
            setState(() {
              isEditActive = !isEditActive;
              // isEditActive == !isEditActive;
              // The boolean toggle in _editFolder should use the assignment operator = instead of the comparison operator ==.
              // print(isEditActive);
            });
          },
        ),
      ],
    );
  }

  Widget _buildFoldersList(folderData, transitionColor, secondary) {
    final folders = folderData.getAllFolders();
    return Card(
      color: Colors.black,
      shape: const RoundedRectangleBorder(
          side: BorderSide(width: 2, color: Colors.teal),
          borderRadius: BorderRadius.vertical(top: Radius.circular(15), bottom: Radius.circular(15))),
      child: Column(
          children: List.generate(folders.length, (index) {
        final folder = folders[index];
        // print(index);
        final isLastFolder = index == folders.length - 1; // Check if it is the last folder
        // print(isLastFolder);
        // final isEditable = index >= 2 && !isLastFolder; // Folders from index 2 onwards are editable
        final isDisabled = index < 2 || isLastFolder; // Folders at index 0, 1, and the last folder are disabled
        final isEditable = !isDisabled; // Editable if not disabled
        doesSubFolderExist = doesSubFolderExist == folder.subFolders.isNotEmpty;

        // print(doesSubFolderExist); // print(isDisabled);
        return Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children: [
                  _buildFolderInfo(folder, transitionColor, isDisabled, isLastFolder),
                  _buildEditIcon(folder, folderData, isEditable)
                ],
              ),
              if (folder.subFolders.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                  child: _buildSubFoldersList(folder.subFolders, folderData, transitionColor, secondary),
                ),
              if (index != folders.length - 1)
                Padding(
                  padding: EdgeInsets.fromLTRB(10.w, 10, 0, 0),
                  child: Divider(height: 1, color: secondary.withOpacity(0.4)),
                ),
            ],
          ),
        );
      })),
    );
  }

  Widget _buildSubFoldersList(List<Folder> subFolders, folderData, transitionColor, secondary) {
    return Column(
      children: List.generate(subFolders.length, (index) {
        final subFolder = subFolders[index];
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 4, 0, 2),
          child: Column(
            children: [
              Row(
                children: [
                  _buildFolderInfo(subFolder, transitionColor, false, false, isSubFolder: true),
                  _buildEditIcon(subFolder, folderData, true),
                ],
              ),
              if (index != subFolders.length - 1)
                Padding(
                  padding: EdgeInsets.fromLTRB(10.w, 10, 0, 0),
                  child: Divider(height: 1, color: secondary.withOpacity(0.4)),
                ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildFolderInfo(folder, transitionColor, isDisabled, isLastFolder, {bool isSubFolder = false}) {
    return Flexible(
      child: Row(
        children: [
          Icon(
            isLastFolder ? Icons.delete : Icons.folder,
            color: isEditActive
                ? isDisabled
                    ? Colors.grey.withOpacity(0.4)
                    : transitionColor
                : transitionColor,
            size: 25,
          ),
          const SizedBox(
            width: 15,
          ),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    "${folder.name}",
                    softWrap: true,
                    style: TextStyle(
                        height: 1.8,
                        // letterSpacing: 1.02,
                        fontWeight: FontWeight.w700,
                        overflow: TextOverflow.visible,
                        color: isEditActive
                            ? isDisabled
                                ? Colors.grey.withOpacity(0.7)
                                : Colors.white
                            : Colors.white),
                  ),
                ),
                Row(
                  children: [
                    Text("${folder.content_number}",
                        style: TextStyle(
                            height: 1.8,
                            fontWeight: FontWeight.w700,
                            color: isEditActive
                                ? isDisabled
                                    ? Colors.grey.withOpacity(0.7)
                                    : Colors.white
                                : Colors.white)),
                    const SizedBox(width: 10)
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditIcon(folder, folderData, isEditable) {
    String name = folder.name;
    return GestureDetector(
      onTap: () {
        setState(() {
          // print(doesSubFolderExist);
          // doesSubFolderExist = !doesSubFolderExist;
        });
      },
      child: isEditActive
          ? isEditable
              ? showEditingIcon(folder, folderData, name)
              : Container()
          : Icon(Icons.keyboard_arrow_right_outlined, color: Colors.white.withOpacity(0.6)),
      // color: doesSubFolderExist ? Colors.yellow : Colors.white.withOpacity(0.6)),
    );
  }
}

// Padding(
// padding: const EdgeInsets.all(8.0),
// child: Text("Date Created: $date",
//     style: const TextStyle(
//       fontWeight: FontWeight.w700,
//       color: Colors.white,
//     )),
//   )


