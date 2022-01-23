class ExamTable {
  late String id, name,  year;
  late DateTime date;


  ExamTable({id, name, date, year});

  ExamTable.fromFirebase(var data) {
    this.id = data['id'];
    this.name = data['name'];
    this.date = data['date'].toDate();
    this.year = data['year'];
  }
}
