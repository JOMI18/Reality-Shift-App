import 'package:reality_shift/imports.dart';

class Folder {
  int id;
  int content_number;
  String name;
  String dateCreated;
  List<Folder> subFolders;
  List<Note> notes;
  String? route;

  Folder({
    required this.name,
    required this.dateCreated,
    this.subFolders = const [], // Initialize with an empty list
    this.notes = const [], // Initialize with an empty list
    required this.id,
    required this.content_number,
    this.route,
  });

  Folder copyWith({
    int? id,
    String? name,
    String? dateCreated,
    int? content_number,
    String? route,
    List<Folder>? subFolders,
    List<Note>? notes,
  }) {
    return Folder(
      id: id ?? this.id,
      name: name ?? this.name,
      dateCreated: dateCreated ?? this.dateCreated,
      content_number: content_number ?? this.content_number,
      route: route ?? this.route,
      subFolders: subFolders ?? this.subFolders,
      notes: notes ?? this.notes,
    );
  }

  // The copyWith method is implemented in the Folder class to facilitate copying a folder with updated properties.
  // The copyWith method is a common pattern in Dart, especially when dealing with immutable objects. It allows you to create a new instance of a class by copying the existing instance and optionally changing some of its properties.
}
