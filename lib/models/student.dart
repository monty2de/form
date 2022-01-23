class Student {
  // ignore: non_constant_identifier_names
  late String id, name , BLocation, email, location, number, sex, year;
  late DateTime BDate;

  // ignore: non_constant_identifier_names
  Student({id, name, BDate, BLocation, email, location, number, sex, year});

  Student.fromFirebase(var data) {
    this.id = data['id'];
    this.name = data['name'];
    this.BDate = data['BDate'].toDate();
    this.BLocation = data['BLocation'];
    this.email = data['email'];
    this.location = data['location'];
    this.number = data['number'];
    this.sex = data['sex'];
    this.year = data['year'];
  }
}
