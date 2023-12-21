import 'package:get/get.dart';
import 'package:multichatapp/const/const.dart';

class NavController extends GetxController{
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getusername();
  }
  var currentindex = 0.obs;

 var username = '';
 getusername()async{
  var n = await firestore.collection(usercollection).where('id',isEqualTo: currentuser!.uid).get().then((value) {
    if(value.docs.isNotEmpty){
      return value.docs.single['name'];
    }
  });
  username = n;
  

 }

}