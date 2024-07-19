// import 'package:flutter/material.dart';

class Folder {
  String name;
  DateTime dateAdded;
  List<Folder> subFolders;
  List<String> notes;
  String? route;

  Folder(
      {required this.name,
      required this.dateAdded,
      this.subFolders = const [],
      this.notes = const [],
      route});
}
