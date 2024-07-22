import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reality_shift/imports.dart';

class FolderData extends ChangeNotifier {
  List<Folder> allFolders = [
    Folder(
        id: 0,
        name: "All Notes", // notes: "",
        content_number: 12,
        // subFolders: List.filled(2, Fo),
        dateCreated: DateFormat('MM/dd/yyyy')
            .format(DateTime.now().subtract(const Duration(days: 300))),
        route: "all"),
    Folder(
        id: 1,
        name: "Quick notes", // notes: "",
        content_number: 4,
        // subFolders: List.filled(2, Fo),
        dateCreated: DateFormat('MM/dd/yyyy')
            .format(DateTime.now().subtract(const Duration(days: 250))),
        route: "quick"),
    Folder(
        id: 2,
        name: "CUISINE IN America", // notes: "",
        content_number: 0,
        // subFolders: List.filled(2, Fo),
        dateCreated: DateFormat('MM/dd/yyyy')
            .format(DateTime.now().subtract(const Duration(days: 250))),
        route: "cuisine"),
  ];

  List<Folder> getAllFolders() {
    return allFolders;
  }

  void addNewFolders(folder) {
    allFolders.add(folder);
    notifyListeners();
  }

  void deleteFolder(Folder folder) {
    allFolders.remove(folder);
    notifyListeners();
  }

  void renameFolder(Folder folder, String name) {
    for (int i = 0; i < allFolders.length; i++) {
      if (allFolders[i].id == folder.id) {
        allFolders[i].name = name;
        break;
      }
    }
    notifyListeners();
  }
}
