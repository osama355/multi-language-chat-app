import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:multichatapp/Utility/toastmasseage.dart';
import 'package:multichatapp/component/button.dart';
import 'package:multichatapp/const/const.dart';

class UserWiseprfile extends StatefulWidget {
  final String recieverName;
  final String recieverId;
  final String recieverProfile;
  const UserWiseprfile({super.key, required this.recieverId, required this.recieverName, required this.recieverProfile});

  @override
  State<UserWiseprfile> createState() => _UserWiseprfileState();
}

class _UserWiseprfileState extends State<UserWiseprfile> {

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  inviteFriend()async{
    final String userId = auth.currentUser!.uid;
    final senderData = await firestore.collection('User').doc(userId).get();
    await firestore.collection("requests").doc('$userId - ${widget.recieverId}').set({
      'senderId':auth.currentUser!.uid,
      'recieverId':widget.recieverId,
      'senderName': senderData.data()?['name'],
      'senderProfile': senderData.data()?['imageurl'],
      'recieverName':widget.recieverName,
      'recieverProfile': widget.recieverProfile,
      'requestStatus':'Pending',
    }).then((value){
      Utils().toastMessage("Request Has been Send");
    }).catchError((error){
      Utils().toastMessage(error.toString());
    });
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recieverName.toString()),
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: context.screenHeight * 1,
              width: double.infinity,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(imgbackgorund), fit: BoxFit.fill)),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                      ),
                      Image.asset(
                        personimg,
                        width: 70,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).white.make(),
                      20.heightBox,
                      SizedBox(
                          width: context.screenWidth - 200,
                          child: ButtonScreen(
                              title: "Invite Friend",
                              buttoncolor: Colors.blue,
                              onpress: () {
                                inviteFriend();
                              }))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
