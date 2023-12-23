import 'package:get/get.dart';
import 'package:multichatapp/Service/firebase_service.dart';
import 'package:multichatapp/component/button.dart';
import 'package:multichatapp/const/const.dart';
import 'package:multichatapp/controller/chat_controller.dart';


Widget exitsdialog({data,context}){
  return Dialog(
  
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15)
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Comfirm".text.fontWeight(FontWeight.bold).make(),
        10.heightBox,
        "Are you sure you want to Delete Msg?".text.size(18).make(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
             ButtonScreen(title: "Yes", onpress: (){
              Firebaseservice.deletedoc(chatid: Get.put(Chatcontroller()).chatDocId,msgid: data);
               }),
          
            ButtonScreen(title: "No", onpress: (){
              Navigator.pop(context);
              
            }),
           

          ],
        )
        


      ],
    ).box.white.roundedSM.padding ( const EdgeInsets.all(4)).make()
  );
}