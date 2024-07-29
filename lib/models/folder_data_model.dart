import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reality_shift/imports.dart';

class FolderData extends ChangeNotifier {
  List<Folder> allFolders = [
    Folder(id: 0, name: "All Notes", content_number: 0, dateCreated: "02/12/2024", route: "all"),
    Folder(id: 1, name: "Quick notes", content_number: 0, dateCreated: "02/12/2024", route: "quick"),
    Folder(id: 3, name: "Recently Deleted", content_number: 0, dateCreated: "02/12/2024", route: "deleted"),
  ];

  List<Folder> getAllFolders() {
    // return allFolders;
    return List.unmodifiable(allFolders);
  }

  void addNewFolders(folder) {
    allFolders.add(folder);
    sortFolders();
    notifyListeners();
  }

  void deleteFolder(Folder folder) {
    allFolders.remove(folder);
    sortFolders();
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

  void addSubFolders(Folder parentFolder, Folder subfolder) {
    for (int i = 0; i < allFolders.length; i++) {
      if (allFolders[i].id == parentFolder.id) {
        // allFolders[i].subFolders.add(subfolder);
        allFolders[i].subFolders = List.from(allFolders[i].subFolders)..add(subfolder);
        // When modifying subFolders, a new list is created using List.from to ensure the list is modifiable before adding or removing subfolders.
        break;
      }
    }
    notifyListeners();
  }

  void removeSubFolders(Folder parentFolder, Folder subfolder) {
    for (var i = 0; i < allFolders.length; i++) {
      if (allFolders[i].id == parentFolder.id) {
        // allFolders[i].subFolders.remove(subfolder);
        allFolders[i].subFolders = List.from(allFolders[i].subFolders)..remove(subfolder);
        // The .. syntax in Dart is called the cascade operator. It allows you to perform multiple operations on the same object without needing to refer to that object more than once.
        break;
      }
    }
    notifyListeners();
  }

  void sortFolders() {
    allFolders.sort((a, b) {
      if (a.name == "Recently Deleted") return 1;
      if (b.name == "Recently Deleted") return -1;
      return 0;
    });
// If the comparison returns 1, the item a will be placed after item b in the sorted list.
// If the comparison returns -1, the item a will be placed before item b in the sorted list.
// If the comparison returns 0, the order of a and b relative to each other remains unchanged.
  }

  void addNoteToFolder(folder, Note note) {
    for (var i = 0; i < allFolders.length; i++) {
      if (allFolders[i].id == folder.id) {
        allFolders[i].notes.add(note);
        allFolders[i].content_number++;
        allFolders[i].dateCreated = DateFormat('MM/dd/yyyy').format(DateTime.now());
        break;
      }
    }
    notifyListeners();
  }

  void deleteNoteFromFolder(folder, Note note) {
    for (var i = 0; i < allFolders.length; i++) {
      if (allFolders[i].id == folder.id) {
        allFolders[i].notes.remove(note);
        allFolders[i].content_number--;
        break;
      }
    }
    notifyListeners();
  }
}
