import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:form/main.dart';
import 'package:form/models/board.dart';

class BoardController {
  var item = <Board>[];

  index(String boardName) async {
    var q = await FirebaseFirestore.instance
        .collection(isTestMood ? 'boards' : 'boards')
        .where('name', isEqualTo: boardName)
        .get();
    item = [];
    q.docs.forEach((DocumentSnapshot element) {
      Map<String, dynamic> data = element.data() as Map<String, dynamic>;

      item.add(Board.fromFirebase(data));
    });

    return item;
  }

  void delet(String id) async {
    await FirebaseFirestore.instance
        .collection(isTestMood ? 'boards' : 'boards')
        .doc(id)
        .delete();
  }
}
