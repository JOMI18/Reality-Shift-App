import 'package:flutter/material.dart';
import 'package:reality_shift/imports.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  TextEditingController folderNameController = TextEditingController();

  List notes = [
    {"folder": "All Continents", "number": "120", "routes":"all_notes"},
    {"folder": "Notes", "number": "60"},
    {"folder": "Cultures", "number": "40"},
    {"folder": "Food", "number": "20"},
  ];
  // add folder functionality will push into
  @override
  Widget build(BuildContext context) {
    Color secondary = Utilities().appColors(context).secondary;
    // Color primary = Utilities().appColors(context).primary;
    Color unchanged = const Color.fromARGB(255, 15, 34, 45);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: CustomAppBar().generalbar(context, "My Quick Note Memo Pad:"),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                ComponentSlideIns(
                  beginOffset: const Offset(2, 0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              CreateNew.showFolderDialog(
                                context,
                                name: 'Create New Folder',
                                hint: 'Enter folder name',
                                inputCt: folderNameController,
                                action: "Create",
                                onpressed: () {
                                  // verify in back end first
                                  String folderName = folderNameController.text;
                                  if (folderName != "") {
                                    setState(() {
                                      notes.add({"folder": folderName});
                                    });
                                  } else {
                                    return;
                                  }

                                  Navigator.of(context).pop();
                                },
                              );
                            },
                            child: Icon(
                              Icons.create_new_folder_rounded,
                              color: secondary,
                              size: 26,
                            ),
                          ),
                          Icon(
                            Icons.edit_square,
                            color: secondary,
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Folders".toUpperCase(),
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.arrow_drop_down_rounded,
                            color: secondary,
                            size: 25,
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(22.w, 6, 25.w, 2),
                        child: Divider(
                          height: 2,
                          thickness: 4,
                          color: secondary,
                        ),
                      )
                    ],
                  ),
                ),
                ComponentSlideIns(
                  beginOffset: const Offset(-2, 0),
                  child: Column(
                    children: [
                      CustomTextField.input(context,
                          hint: "Search",
                          prefixIcon: Icon(
                            Icons.search,
                            color: secondary,
                          ),
                          suffixIcon: Icon(
                            Icons.mic,
                            color: secondary,
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 6.h,
                ),
                ComponentSlideIns(
                  beginOffset: const Offset(2, 0),
                  child: Column(
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: notes.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                title: Text(notes[index]["folder"]),
                                leading: Icon(
                                  Icons.folder,
                                  color: unchanged,
                                ),
                                trailing: SizedBox(
                                  width: 12.w,
                                  child: Row(
                                    children: [
                                      Text(notes[index]["number"] ?? '0'),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        Icons.keyboard_arrow_right_outlined,
                                        color: unchanged,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })
                    ],
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                ComponentSlideIns(
                    beginOffset: const Offset(0, 2),
                    child: Btns().continentBtn(context, "Edit Folders", () {}))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
