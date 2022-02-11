class ExamResult {
  late String id, studentName, year, subjectName, degree ,semister;

  ExamResult({id, studentName, year, degree, subjectName , semister});

  ExamResult.fromFirebase(var data) {
    this.id = data['id'];
    this.studentName = data['studentName'];
    this.year = data['year'];
    this.degree = data['degree'];
    this.subjectName = data['subjectName'];
    this.semister = data['semister'] ?? '';
  }
}
