class Student {
  final String id;
  final String name;
  final String? bLocation;
  final String email;
  final String? location;
  final String? number;
  final String? sex;
  final String year;
  final String pass;
  final String? status;
  final String? part;
  final String shift;
  final DateTime? bDate;

  Student({
    this.bDate,
    required this.id,
    required this.name,
    this.bLocation,
    required this.email,
    this.location,
    this.number,
    this.sex,
    required this.year,
    required this.pass,
    this.status,
    this.part,
    required this.shift,
  });

  factory Student.fromFirebase(Map<String, dynamic> map) {
    return Student(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      bLocation: map['BLocation'],
      email: map['email'] ?? '',
      location: map['location'],
      number: map['number'].toString(),
      sex: map['sex'],
      year: map['year'] ?? '',
      pass: map['pass'] ?? '',
      status: map['status'],
      part: map['part'],
      shift: map['shift'] ?? '',
      bDate: DateTime.parse(map['BDate']),
    );
  }
}
