class Note {
  int id;
  String title;
  String text;
  String dateCreated;
  String? dateEdited;

  Note({
    required this.id,
    required this.title,
    required this.text,
    required this.dateCreated,
    this.dateEdited,
  });
}
