class ExamResult {
  final String? id,
      studentName,
      year,
      subjectName,
      degree,
      semister,
      semersterDegree,
      resolutionDegree,
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
      required this.resolutionDegree,
      required this.avarege});

  factory ExamResult.fromFirebase(var data) {
    return ExamResult(
      id: data['id'],
      studentName: data['studentName'],
      year: data['year'],
      degree: data['degree']?.toString() ?? '',
      semister: data['semister'] ?? '',
      subjectName: data['subjectName'] ?? '',
      finalDegree: data['finalDegree'] ?? '',
      semersterDegree: data['semersterDegree'] ?? '',
      avarege: data['avarege'] ?? '',
      resolutionDegree: data['resolutionDegree'] ?? '',
    );
  }
}
