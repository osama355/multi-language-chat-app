import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:multichatapp/Screens/friendprofile_Screen/userwiseProfile.dart';
import 'package:multichatapp/Service/firebase_service.dart';
import 'package:multichatapp/const/const.dart';

class AddFriends extends StatefulWidget {
  const AddFriends({
    super.key,
  });

  @override
  State<AddFriends> createState() => _AddFriendsState();
}

class _AddFriendsState extends State<AddFriends> {
  final searchcontroller = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchcontroller,
                decoration: const InputDecoration(
                    hintText: addfriends,
                    suffixIcon: Icon(Icons.search),
                    fillColor: lightGrey,
                    filled: true,
                    border: InputBorder.none,
                    isDense: true,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.red,
                    ))),
                onChanged: (String value) {
                  setState(() {
                   
                  });
                },
              ),
            ),
            StreamBuilder(
                stream: Firebaseservice.fatchuser(),
                builder:
                    (BuildContext context, AsyncSnapshot<QuerySnapshot> snaphot) {
                  if (!snaphot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: redColor,
                      ),
                    );
                  } else {
                    var data = snaphot.data!.docs;
                    return Expanded(
                        child: ListView.builder(
                        
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              String name = data[index]['name'];
                              String usrId = data[index]['id'];
                              String profileUrl = data[index]['imageurl'];
                              if (searchcontroller.text.isEmpty) {
                                return InkWell(
                                  onTap: () {
                                    Get.to(() => UserWiseprfile(recieverName:name, recieverId:usrId, recieverProfile: profileUrl,));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 4),
                                    child: ListTile(
                                    
                                      leading: CircleAvatar(
                                        radius: 30,
                                        backgroundImage: NetworkImage(
                                            snaphot.data!.docs[index]['imageurl']),
                                      ),
                                      title:
                                          Text(snaphot.data!.docs[index]['name']),
                                    ),
                                  ),
                                );
                              } 
                              else if (name.toLowerCase().contains(
                                  searchcontroller.text
                                      .toLowerCase()
                                      .toLowerCase())) {
                                return InkWell(
                                  onTap: () {
                                    Get.to(() => UserWiseprfile(recieverName:name, recieverId:usrId, recieverProfile: profileUrl, ));
                                  },
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          snaphot.data!.docs[index]['imageurl']),
                                    ),
                                    title:
                                        Text(snaphot.data!.docs[index]['name']),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            }));
                  }
                } 
                ) 
                  ],
                ),
          ),
              // .box
              // .white
              // .padding(const EdgeInsets.all(8))
              // .width(context.screenWidth - 50)
              // .roundedSM
              // .shadowSm
              // .margin(const EdgeInsets.only(top: 20, left: 20))
              // .make()
              ),
    );
  }
}
