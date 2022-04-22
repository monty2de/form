class Curriculum {
  final String id, name, year, semister;
  final int type, units;

  Curriculum({
    required this.id,
    required this.name,
    required this.year,
    required this.type,
    required this.semister,
    required this.units,
  });

  factory Curriculum.fromFirebase(var data) {
    return Curriculum(
      id: data['id'],
      name: data['name'],
      year: data['year'],
      type: data['type'],
      semister: data['semister'] ?? '',
      units: data['units'] ?? '',
    );
  }
}
