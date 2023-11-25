
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multichatapp/Screens/navbar.dart';
import 'package:multichatapp/Utility/toastmasseage.dart';
import 'package:multichatapp/const/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:multichatapp/const/firebase_const.dart';

class AuthController extends GetxController {


  var isloading = false.obs;
  //Login
  Future<UserCredential?> islogin({semail,spassword}) async {
    UserCredential? userCredential;

    try {
     userCredential = await auth.signInWithEmailAndPassword(email: semail, password: spassword).then((value){
      if(auth.currentUser!.emailVerified){
        Utils().toastMessage("Login Sucessfully");
        Get.to(()=> const NavbarScreen());
      }else{
         Utils().toastMessage(
            "Please verify your email by clicking on link sending to you email");
        auth.currentUser!.sendEmailVerification();
      }
     } );
    } on FirebaseAuthException catch (e) {
      Utils().toastMessage(e.toString());
    }
    return userCredential;
  }
//SignUp

  Future<UserCredential?> signup({email, password}) async {
    UserCredential? userCredential;

    try {
    userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      
      Utils().toastMessage(e.toString());
    }
    return userCredential;
  }

  
  //Signout

  signout({context})async{
   try{
   await auth.signOut();

   }
   catch(e){
       VxToast.show(context, msg: e.toString());

   }

  }

  //Store Data..
  stordata({name,password,email}) async {
   
    DocumentReference store =
        await firestore.collection(usercollection).doc(currentuser!.uid);
    store.set(
        {'name': name, 'password': password, 'email': email, 'imageurl': '','id' :currentuser!.uid, 
         
        
        });
  }
}
