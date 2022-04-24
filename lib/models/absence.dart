class Abscence {
  final String stName;
  final String stId;
  final String id;
  final String subject;
  final String year;
  final DateTime date;

  Abscence(
      {required this.stName,
      required this.id,
      required this.subject,
      required this.stId,
      required this.year,
      required this.date});
  factory Abscence.fromfirebase(Map<String, dynamic> map) {
    print(map);
    return Abscence(
        stName: map['stName'] ?? "",
        id: map['id'],
        subject: map['subject'],
        stId: map['stId'],
        year: map['year'] ?? '',
        date: DateTime.parse(map['date']));
  }
}
