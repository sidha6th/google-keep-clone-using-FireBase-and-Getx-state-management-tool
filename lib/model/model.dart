class NoteModel {
  final String? title;
  final String content;
  String? id;
  DateTime? dateTime;
  NoteModel({
    required this.content,
    this.dateTime,
    this.title,
    this.id,
  });
  Map<String, dynamic>toJson() => {
        'title': title,
        'content': content,
        'id': id,
        'dateTime': dateTime?.toUtc(),
      };
  static NoteModel fromJson(Map<String, dynamic> json) {
    return NoteModel(
      title: json['title'],
      dateTime: json['dateTime'].toDate(), 
      content: json['content'],
      id: json['id'],
    );
  }
}
