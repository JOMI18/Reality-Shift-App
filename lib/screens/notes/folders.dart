import 'package:flutter/material.dart';
import 'package:reality_shift/imports.dart';

class MyFolders extends StatefulWidget {
  const MyFolders({super.key});

  @override
  State<MyFolders> createState() => _MyFoldersState();
}

class _MyFoldersState extends State<MyFolders> {
  bool doesSubFolderExist = false;
  bool isEditActive = false;
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
        _buildPopupMenuItem(
            "New", Icons.create_new_folder_sharp, Colors.teal, null),
        _buildPopupMenuItem(
            "Share", Icons.ios_share_rounded, Colors.teal, null),
        _buildPopupMenuItem(
            "Group by Date", Icons.calendar_month, Colors.teal, null,
            isGroupByDate: true),
        _buildPopupMenuItem("Delete", Icons.delete, Colors.red, () {
          folderData.deleteFolder(folder);
        }, isDelete: true),
      ],
    );
  }

  PopupMenuItem<String> _buildPopupMenuItem(
      String title, IconData icon, Color iconColor, VoidCallback? onTap,
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

  Future<String?> showFolderDialog(int id, FolderData folderData,
      {Folder? folder}) {
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
                  folderData.addNewFolders(newFolder);
                  textCt.clear();
                  Navigator.of(context).pop();
                });
              }
            : null);
  }

  @override
  Widget build(BuildContext context) {
    Color secondary = Utilities().appColors(context).secondary;
    Color primary = Utilities().appColors(context).primary;
    return Consumer(
      builder: (context, ref, _) {
        final folderData = ref.read(FolderProvider.notifier).state;
        final selectedTheme = ref.watch(AppThemeProvider)["theme"];
        Color transitionColor =
            selectedTheme == darkTheme ? secondary : primary;
        // final folderData = ref.watch(FolderProvider);
        return Scaffold(
          floatingActionButton: _buildSpeedDial(folderData),
          appBar: CustomAppBar().welcomebar(context, "My Memo Pad:"),
          body: SingleChildScrollView(
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
                              child: Text(
                                "All Folders".toUpperCase(),
                                softWrap: true,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  overflow: TextOverflow.visible,
                                  color: secondary,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
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
                      child: _buildFoldersList(
                          folderData, transitionColor, secondary))
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
            Navigator.pushNamed(context, "notes_pad");
          },
        ),
        SpeedDialChild(
          child: isEditActive
              ? const Icon(Icons.done_all_sharp)
              : const Icon(Icons.edit_square),
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
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(15), bottom: Radius.circular(15))),
      child: Column(
          children: List.generate(folders.length, (index) {
        final folder = folders[index];
        final isEditable =
            index >= 2; // Folders from index 2 onwards are editable
        final isDisabled = index < 2; // Folders at index 0 and 1 are disabled
        // bool isExpanded = doesSubFolderExist == folder.sub_folders.isNotEmpty;

        return Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children: [
                  _buildFolderInfo(folder, transitionColor, isDisabled),
                  if (isEditActive)
                    isEditable
                        ? _buildEditIcon(folder, folderData)
                        : Container(),
                ],
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

  Widget _buildFolderInfo(folder, transitionColor, isDisabled) {
    return Flexible(
      child: Row(
        children: [
          Icon(
            Icons.folder,
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
                    Text(
                      "${folder.content_number}",
                      style: TextStyle(
                          height: 1.8,
                          fontWeight: FontWeight.w700,
                          color: isEditActive
                              ? isDisabled
                                  ? Colors.grey.withOpacity(0.7)
                                  : Colors.white
                              : Colors.white),
                    ),
                    const SizedBox(
                      width: 15,
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditIcon(folder, folderData) {
    String name = folder.name;
    return GestureDetector(
      onTap: () {
        setState(() {
          doesSubFolderExist = !doesSubFolderExist;
        });
      },
      child: isEditActive
          ? showEditingIcon(folder, folderData, name)
          : Icon(
              doesSubFolderExist
                  ? Icons.keyboard_arrow_right_outlined
                  : Icons.expand_more_rounded,
              color: doesSubFolderExist ? Colors.yellow : Colors.white),
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

// fix dialog blog to edit actions and show recently deleted notes
