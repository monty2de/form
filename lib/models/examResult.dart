class ExamResult {
  final String? id,
      studentName,
      year,
      subjectName,
      degree,
      semister,
      semersterDegree,
      finalDegree,
      avarege;

  ExamResult(
      {required this.id,
      required this.studentName,
      required this.year,
      required this.degree,
      required this.subjectName,
      required this.semister,
      required this.semersterDegree,
      required this.finalDegree,
      required this.avarege});

  factory ExamResult.fromFirebase(var data) {
    return ExamResult(
      id: data['id'],
      studentName: data['studentName'],
      year: data['year'],
      degree: data['degree'],
      semister: data['semister'] ?? '',
      subjectName: data['subjectName'] ?? '',
      finalDegree: data['finalDegree'] ?? '',
      semersterDegree: data['semersterDegree'] ?? '',
      avarege: data['avarege'] ?? '',
    );
  }
}
