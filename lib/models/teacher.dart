class Teacher {
  late String id, name, email, location, number, position, pass;
  // ignore: non_constant_identifier_names
  late DateTime BDate;

  // ignore: non_constant_identifier_names
  Teacher({id, name, BDate, email, location, number, position, pass});

  Teacher.fromFirebase(var data) {
    this.id = data['id'];
    this.name = data['name'];
    this.BDate = DateTime.tryParse(data['BDate']) ?? DateTime.now();
    this.email = data['email'];
    this.location = data['location'] ?? '';
    this.number = data['number'] ?? "";
    this.position = data['position'] ?? '';
    this.pass = data['pass'];
  }
}
