

import 'package:get/get.dart';
import 'package:multichatapp/const/const.dart';

class RequestController extends GetxController{
  



Future<void> userFriends(    { String? docuid,     String? uid, String? name, String? profile}) async {
  var store = firestore.collection(usercollection).doc(docuid);

  // Retrieve the current data
  var doc = await store.get();
  var currentFriends = doc.data()?['friends'] ?? [];

  // Add a new friend to the list
  currentFriends.add({
    'id': uid,
    'name': name,
    'profile': profile,
  });

  // Update the 'friends' field in the document
  await store.update({'friends': currentFriends});
}







}