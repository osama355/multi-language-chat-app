import 'package:get/get.dart';
import 'package:multichatapp/Auth/Login.dart';
import 'package:multichatapp/Screens/profile.dart';
import 'package:multichatapp/Utility/toastmasseage.dart';
import 'package:multichatapp/component/button.dart';
import 'package:multichatapp/const/const.dart';

Widget showdialogbox(){

  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      children: [
        "Comfirm".text.fontWeight(FontWeight.bold).make(),
        10.heightBox,
        "Are you Sure you want to Logout".text.size(18).make(),
        Row(
          children: [
            ButtonScreen(title: "Yes", onpress: ()async{
                try{
               await auth.signOut();
                 Get.offAll(const LoginScreen());
              }catch(e){
             Utils().toastMessage(e.toString());
    }
              
            }),
             ButtonScreen(title: "No", onpress: (){
             Get.to(()=> const ProfileScreen());
              
            }),
            
          ],
        )
      ],
    ),
  );
}