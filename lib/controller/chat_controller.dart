import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:multichatapp/Utility/toastmasseage.dart';
import 'package:multichatapp/component/navbar_component.dart';
import 'package:multichatapp/const/const.dart';

class Chatcontroller extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getChatId();
  }

  var chat = firestore.collection(chatcollection);

  var friendName = Get.arguments[0];
  var friendsId = Get.arguments[1];

  var senderName = Get.find<NavController>().username;
  var currentId = currentuser!.uid;
  var isloading = false.obs;

  var msgcontroller = TextEditingController();

  

  dynamic chatDocId;

  getChatId() async {
    isloading(true);
    await chat
        .where('users', isEqualTo: {
          friendsId: null,
          currentId: null,
        })
        .limit(1)
        .get()
        .then((QuerySnapshot snapshot) {
          if (snapshot.docs.isNotEmpty) {
            chatDocId = snapshot.docs.single.id;
          } else {
            chat.add({
              'created_on': null,
              'last_msg': null,
              'users': {friendsId: null, currentId: null},
              'toId': '',
              'fromId': '',
              'friend_name': friendName,
              'sender_name': senderName,
            }).then((value) {
              {
                chatDocId = value.id;
              }
            });
          }
        });
    isloading(false);
  }

  sendMsg(String msg) async {
    if (msg.trim().isNotEmpty) {
      chat.doc(chatDocId).update({
        'created_on': FieldValue.serverTimestamp(),
        'last_msg': msg,
        'toId': friendsId,
        'fromId': currentId,
        
      });
      chat.doc(chatDocId).collection(messagecollection).doc().set({
        'created_on': FieldValue.serverTimestamp(),
      
        'msg': msg,
        'uid': currentId,
        'read': false,
      });

    
        
    
    }
  }
  //update read status....................................................................
   updateread(){
       
       chat.doc(chatDocId).collection(messagecollection).doc().update({
      'read': true,
     }).then((value) {
      Utils().toastMessage("Updated Read");
     }).onError((error, stackTrace) {
             Utils().toastMessage(error.toString());

     });
  }

  //   chat
    //     .doc(chatDocId)
    //     .collection(messagecollection)
    //     .where('uid', isEqualTo: friendsId)
    //     .where('read',isNotEqualTo: '')
    //     .get()
    //     .then((QuerySnapshot snapshot) {
    //   if (snapshot.docs.isNotEmpty) {
    //     snapshot.docs.forEach((doc) {
    //       doc.reference.update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
    //     });
    //   }
    // });

  
  






  

}
