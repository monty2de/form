class News {
  late String id, title, body;

  News({required this.id, required this.body, required this.title});

  News.fromFirebase(var data) {
    this.id = data['id'];
    this.title = data['title'];
    this.body = data['body'];
  }
}
