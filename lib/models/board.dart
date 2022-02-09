class Board {
  late String id, name, teacherName, isBoss;

  Board({id, name, teacherName, isBoss});

  Board.fromFirebase(var data) {
    this.id = data['id'];
    this.name = data['name'];
    this.isBoss = data['isBoss'];
    this.teacherName = data['teacherName'];
  }
}
