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
    return firestore.collection(usercollection).snapshots();
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
 

   static getfriend(){
    return firestore.collection(usercollection).where('id',isEqualTo:  currentuser!.uid).snapshots();
  }
 
  
}
