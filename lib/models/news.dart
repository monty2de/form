class News {
  late String id, title, body;

  News({id, body, title});

  News.fromFirebase(var data) {
    this.id = data['id'];
    this.title = data['title'];
    this.body = data['body'];
  }
}
