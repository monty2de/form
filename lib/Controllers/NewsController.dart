import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:form/main.dart';
import 'package:form/models/news.dart';

class NewsController {
  var newsItem = <News>[];

  index() async {
    var q = await FirebaseFirestore.instance
        .collection(isTestMood ? 'newsTest' : 'news')
        .get();
    newsItem = [];
    q.docs.forEach((DocumentSnapshot element) {
      Map<String, dynamic> data = element.data() as Map<String, dynamic>;

      newsItem.add(News.fromFirebase(data));
    });

    return newsItem;
  }

  void delet(String id) async {
    await FirebaseFirestore.instance
        .collection(isTestMood ? 'newsTest' : 'news')
        .doc(id)
        .delete();
  }
}
