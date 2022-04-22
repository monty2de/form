class ExamTable {
  late String id, name, year, semister;
  late DateTime date;

  ExamTable({id, name, date, year, semister});

  ExamTable.fromFirebase(var data) {
    this.id = data['id'];
    this.name = data['name'];
    this.date = DateTime.parse(data['date']);
    this.year = data['year'];
    this.semister = data['semister'];
  }
}
