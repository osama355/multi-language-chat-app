
import 'package:get/get.dart';
import 'package:multichatapp/Auth/Login.dart';
import 'package:multichatapp/Utility/toastmasseage.dart';
import 'package:multichatapp/const/const.dart';




const profilelist = [email, name, logout];

var profileiconlist = [
  const Icon(Icons.email),
  const Icon(Icons.person),
  const Icon(
    Icons.logout,
    color: redColor,
  ).onTap(()async  {
    try{
               await auth.signOut();
                 Get.offAll(const LoginScreen());
              }catch(e){
             Utils().toastMessage(e.toString());
    }
   
              
      

    
  })
];
