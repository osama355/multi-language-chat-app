import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multichatapp/Utility/toastmasseage.dart';
import 'package:multichatapp/const/const.dart';
import 'package:path/path.dart';

class ProfileImagePicker extends GetxController{
  var namecontroller = TextEditingController();
  var passcontroller = TextEditingController();
  var conformpass = TextEditingController();


  var imgpath = ''.obs;
  var profilelink = "";
  var isloading = false.obs;
  var  isnum = ''.obs;
  changeimage()async{
 try{
   final img = await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 100);
  if (img == null) return;
  imgpath.value =  img.path;


 } on PlatformException   catch(e){
   Utils().toastMessage(e.toString());

 }
  }
//imageupload
  uploadimage() async{
     var filename = basename(imgpath.value);
     var desination = 'images/${currentuser!.uid}/$filename';
     Reference ref = FirebaseStorage.instance.ref().child(desination);
     await  ref.putFile(File(imgpath.value));
     profilelink = await ref.getDownloadURL();
  }

  updatedoc({name,password,imgurl})async{
    var store = firestore.collection(usercollection).doc(currentuser!.uid);
//document update
 await   store.set({
  'name': name,
  'password': password,
   'imageurl': imgurl,
},SetOptions(merge: true));
isloading(false);

  }
  //change password in auth form this method.................

changeauthpassword({email,password,newpass})async{
final crid = EmailAuthProvider.credential(email: email, password: password);
await currentuser!.reauthenticateWithCredential(crid).then((value) {
  currentuser!.updatePassword(newpass);
}).catchError((error){
  Utils().toastMessage(error.toString());

});

}  


}