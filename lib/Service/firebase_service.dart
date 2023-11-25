import 'package:multichatapp/const/const.dart';

class Firebaseservice {
  static getuser(uid) {
    return firestore
        .collection(usercollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }

  static fatchuser() {
    return firestore.collection(usercollection).snapshots();
  }

  static getname({uid}) {
    return firestore
        .collection(usercollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }
}
