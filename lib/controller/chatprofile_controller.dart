import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:multichatapp/const/const.dart';

class ChatProfileController extends GetxController {
//   var temp = [];

//  updatechatprofile()async{
//    var store = await firestore.collection(usercollection).snapshots();
//      for(var item in store['friends']){
//         if(item['id'] == currentuser!.uid){
//           temp.add(item);

//         }
//      }

//      print(temp);
//  }

// Function to update profile in friend arrays across user collections
  Future<void> updateProfileEverywhere({getimg}) async {
    // Retrieve all user collections
    QuerySnapshot<Map<String, dynamic>> userCollections =
        await FirebaseFirestore.instance.collection('User').get();

    // Iterate through each user's document
    for (QueryDocumentSnapshot<Map<String, dynamic>> userDoc
        in userCollections.docs) {
      // Get the friend array from the user document
      List<dynamic> friends = userDoc.data()['friends'];
     if(friends != null) {
      
        for (dynamic friend in friends) {
          // Check if the friend's ID matches your ID
          if (friend['id'] == currentuser!.uid) {
            // Get the current friend's ID
            String friendId = friend['id'];

            // Update the profile of the friend
           

            await FirebaseFirestore.instance
                .collection('User')
                .doc(userDoc.id)
                .update({
              'friends': FieldValue.arrayUnion([
                {
                  'profile': getimg
                }
              ]),
            });
            print(
                "Updated data: ${await FirebaseFirestore.instance.collection('User').doc(userDoc.data()['name']).get()}");
          }
        }
      }
      else{
              print("No friends data available for user ${userDoc.id}");
      }

      // Iterate through each friend in the friend array
    }
  }
}
