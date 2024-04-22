import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multichatapp/const/const.dart';

class Firebaseservice {
  static getuser(uid) {
    return firestore
        .collection(usercollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }

  static fatchuser() {
    return firestore
        .collection(usercollection)
        .where('id', isNotEqualTo: currentuser!.uid)
        .snapshots();
  }

  static getname({uid}) {
    return firestore
        .collection(usercollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }

  //get userfriend......................................

  // static getfriend({uid}){
  //  return firestore.collection(usercollection).where('friends',arrayContains: uid).snapshots();

  // }

  static getfriend() {
    return firestore
        .collection(usercollection)
        .where('id', isEqualTo: currentuser!.uid ,)
        .snapshots();
  }
//this is test get data.....................................................................................
  static getfriendname({uid}){
    return firestore.collection(usercollection).where('friends',arrayContains: uid).snapshots();
  }
  

  //..............................................................................................................................

  //get all msg.....
  static getallmessage({docid}) {
    return firestore
        .collection(chatcollection)
        .doc(docid)
        .collection(messagecollection)
        .orderBy('created_on', descending: false)
        .snapshots();
  }

  //get msg...............................................
  static getlastmessage(){
   return firestore.collection(chatcollection).where('from_id',isEqualTo: currentuser!.uid).get();  
    




 }
 static deletedoc({chatid,msgid}){
    return firestore.collection(chatcollection).doc(chatid).collection(messagecollection).doc(msgid).delete();
 }

 static Stream<QuerySnapshot> checkusername() {
  return firestore.collection(usercollection).snapshots();
}
 

  
}
