class Curriculum {
  final String id, name, year;
  final int type;

  Curriculum({
    required this.id,
    required this.name,
    required this.year,
    required this.type,
  });

  factory Curriculum.fromFirebase(var data) {
    return Curriculum(
        id: data['id'],
        name: data['name'],
        year: data['year'],
        type: data['type']);
  }
}
