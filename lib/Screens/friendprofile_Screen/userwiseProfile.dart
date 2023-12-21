import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:multichatapp/Service/firebase_service.dart';
import 'package:multichatapp/Utility/toastmasseage.dart';
import 'package:multichatapp/component/button.dart';
import 'package:multichatapp/const/const.dart';
import 'package:multichatapp/controller/profile_controller.dart';

class UserWiseprfile extends StatefulWidget {
  final String recieverName;
  final String recieverId;
  final String recieverProfile;

  const UserWiseprfile(
      {super.key,
      required this.recieverId,
      required this.recieverName,
      required this.recieverProfile});

  @override
  State<UserWiseprfile> createState() => _UserWiseprfileState();
}

class _UserWiseprfileState extends State<UserWiseprfile> {
  bool isloading = false;
  var controller = Get.put(ProfileImagePicker());

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  inviteFriend() async {
    setState(() {
      isloading = true;
    });

    final String userId = auth.currentUser!.uid;
    final senderData = await firestore.collection('User').doc(userId).get();
    await firestore
        .collection("requests")
        .doc('$userId - ${widget.recieverId}')
        .set({
      'senderId': auth.currentUser!.uid,
      'recieverId': widget.recieverId,
      'senderName': senderData.data()?['name'],
      'senderProfile': senderData.data()?['imageurl'],
      'recieverName': widget.recieverName,
      'recieverProfile': widget.recieverProfile,
      'requestStatus': 'Pending',
    }).then((value) {
      setState(() {
        isloading = false;
      });

      Utils().toastMessage("Request Has been Send");
     // Get.off(() => const FriendHomeScreen());
    }).catchError((error) {
      setState(() {
        isloading = false;
      });

      Utils().toastMessage(error.toString());
      setState(() {
        isloading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Firebaseservice.getfriend();
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.recieverName.toString()),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: Firebaseservice.getfriend(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Text('No data found');
              } else {
                // Accessing data of the first document (assuming there's only one)
                var doc = snapshot.data!.docs[0];
                var data = doc.data() as Map<String, dynamic>;

                // Check if the 'friends' list has the same user
                bool isFriend = data['friends'] != null &&
                    data['friends']
                        .any((friend) => friend['id'] == widget.recieverId);
                return isFriend
                    ? SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            Container(
                              height: context.screenHeight * 1,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(imgbackgorund),
                                      fit: BoxFit.fill)),
                              child: SafeArea(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 20),
                                      ),
                                      widget.recieverProfile == '' &&
                                              controller.imgpath.isEmpty
                                          ? Image.asset(
                                              personimg,
                                              width: 100,
                                              fit: BoxFit.cover,
                                            )
                                              .box
                                              .roundedFull
                                              .clip(Clip.antiAlias)
                                              .white
                                              .make()
                                          : widget.recieverProfile != '' &&
                                                  controller.imgpath.isEmpty
                                              ? Image.network(
                                                  widget.recieverProfile,
                                                  fit: BoxFit.cover,
                                                  width: 100,
                                                )
                                                  .box
                                                  .roundedFull
                                                  .clip(Clip.antiAlias)
                                                  .white
                                                  .make()
                                              : Image.file(
                                                  File(
                                                      controller.imgpath.value),
                                                  width: 100,
                                                  fit: BoxFit.cover,
                                                )
                                                  .box
                                                  .roundedFull
                                                  .clip(Clip.antiAlias)
                                                  .white
                                                  .make(),
                                      20.heightBox,
                                      "Already Friends"
                                          .text
                                          .fontWeight(FontWeight.bold)
                                          .size(20)
                                          .make(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            Container(
                              height: context.screenHeight * 1,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(imgbackgorund),
                                      fit: BoxFit.fill)),
                              child: SafeArea(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 20),
                                      ),
                                      widget.recieverProfile == '' &&
                                              controller.imgpath.isEmpty
                                          ? Image.asset(
                                              personimg,
                                              width: 100,
                                              fit: BoxFit.cover,
                                            )
                                              .box
                                              .roundedFull
                                              .clip(Clip.antiAlias)
                                              .white
                                              .make()
                                          : widget.recieverProfile != '' &&
                                                  controller.imgpath.isEmpty
                                              ? Image.network(
                                                  widget.recieverProfile,
                                                  fit: BoxFit.cover,
                                                  width: 100,
                                                )
                                                  .box
                                                  .roundedFull
                                                  .clip(Clip.antiAlias)
                                                  .white
                                                  .make()
                                              : Image.file(
                                                  File(
                                                      controller.imgpath.value),
                                                  width: 100,
                                                  fit: BoxFit.cover,
                                                )
                                                  .box
                                                  .roundedFull
                                                  .clip(Clip.antiAlias)
                                                  .white
                                                  .make(),
                                      20.heightBox,
                                      SizedBox(
                                          width: context.screenWidth - 200,
                                          child: controller.isloading.value
                                              ? const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                )
                                              : ButtonScreen(
                                                  title: "Invite Friend",
                                                  isloading: isloading,
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
                      );
              }
            }));
  }
}
