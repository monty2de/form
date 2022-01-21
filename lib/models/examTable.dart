class ExamTable {
  late String id, name, date, year;

  ExamTable({id, name, date, year});

  ExamTable.fromFirebase(var data) {
    this.id = data['id'];
    this.name = data['name'];
    this.date = data['date'];
    this.year = data['year'];
  }
}
