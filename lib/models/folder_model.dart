class Folder {
  int id;
  int content_number;
  String name;
  String dateCreated;
  List<Folder> subFolders;
  List<String> notes;
  String? route;

  Folder(
      {required this.name,
      required this.dateCreated,
      this.subFolders = const [],
      this.notes = const [],
      required this.id,
      required this.content_number,
      this.route});
}
