class Worn {
  late String id, body, stname;

  Worn({id, body, stname});

  Worn.fromFirebase(var data) {
    this.id = data['id'];
    this.body = data['body'];
    this.stname = data['stname'];
  }
}
