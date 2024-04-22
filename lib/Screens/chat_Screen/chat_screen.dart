//import 'dart:math';

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:multichatapp/Screens/chat_Screen/MessageScreen.dart';
import 'package:multichatapp/Service/firebase_service.dart';
import 'package:multichatapp/const/const.dart';
import 'package:multichatapp/controller/profile_controller.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
   final chatsearch = TextEditingController();
  @override
  Widget build(BuildContext context) {

    var controller = Get.put(ProfileImagePicker());
   

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: green,
          title: "Chat".text.fontWeight(FontWeight.bold).white.make(),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: chatsearch,
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

                      print(value);
                    });
                  },
                ),
              ),
              Expanded(
                child: StreamBuilder(
                  stream: Firebaseservice.getfriend(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(color: redColor,strokeWidth: 2),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: "Waiting".text.makeCentered(),
                      );
                    } else if (snapshot.hasError) {
                      return "Something is Wrong".text.makeCentered();
                    } else if (snapshot.data!.docs.isEmpty) {
                      return "No Friends yet".text.makeCentered();
                    } 
                     

                    
                    else {
                      var data = snapshot.data!.docs[0];
                      if(data['friends'].isEmpty){
                         return "No Friends yet".text.makeCentered();

                      }
                      
                     else{
                       return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ListView(
                                  shrinkWrap: true,
                                  children: List.generate(
                                      data['friends'].length, (index) {
                                    String name = data['friends'][index]['name'];
                                    if (chatsearch.text.isEmpty) {
                                      return Column(
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 4),
                                              child: ListTile(
                                                onTap: () {
                                                  Get.to(
                                                      () => MessageScreen(
                                                            data: {
                                                              'name':
                                                                  data['friends']
                                                                          [
                                                                          index]
                                                                      ['name'],
                                                              'profile':
                                                                  data['friends']
                                                                          [
                                                                          index]
                                                                      [
                                                                      'profile'],
                                                            },
                                                          ),
                                                      arguments: [
                                                        data['friends'][index]
                                                            ['name'],
                                                        data['friends'][index]
                                                            ['id'],
                                                      ]);
                                                },
                                                 leading:
                                                   data['friends'][index]['profile'] == ''  ?
                           Image.asset(personimg,width: 50,fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).white.make()
                           //if data is not empty but profilelink is empty.....
                           : data['friends'][index]['profile'] != '' ?
                           
                           Image.network(data['friends'][index]['profile'],width: 70,fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).gray500.make()
                           : 
                           
                           //if both are empty...........
                           Image.file(File(controller.imgpath.value),
                           width: 80,
                           fit: BoxFit.cover,
                           
                           ).box.roundedFull.clip(Clip.antiAlias).gray500.make(),
                                                 
                                                 
                                                 // CircleAvatar(
                                                //     radius: 25,
                                                //     backgroundImage:
                                                //         NetworkImage(
                                                //             data['friends']
                                                //                     [index]
                                                //                 ['profile'])),
                                                 title:
                                                    "${data['friends'][index]['name']}"
                                                        .text
                                                        .make(),
                                              )),
                                          const Divider()
                                        ],
                                      );
                                    } else if (name.toLowerCase().contains(
                                        chatsearch.text
                                            .toLowerCase()
                                            .toLowerCase())) {
                                      return Column(
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 4),
                                              child: ListTile(
                                                onTap: () {
                                                  Get.to(
                                                      () => MessageScreen(
                                                            data: {
                                                              'name':
                                                                  data['friends']
                                                                          [
                                                                          index]
                                                                      ['name'],
                                                              'profile':
                                                                  data['friends']
                                                                          [
                                                                          index]
                                                                      [
                                                                      'profile'],
                                                            },
                                                          ),
                                                      arguments: [
                                                        data['friends'][index]
                                                            ['name'],
                                                        data['friends'][index]
                                                            ['id'],
                                                      ]);
                                                },
                                                leading: CircleAvatar(
                                                    radius: 25,
                                                    backgroundImage:
                                                        NetworkImage(
                                                            data['friends']
                                                                    [index]
                                                                ['profile'])),
                                                title:
                                                    "${data['friends'][index]['name']}"
                                                        .text
                                                        .make(),
                                              )),
                                          const Divider()
                                        ],
                                      );
                                    }
                                    else{
                                      return Container();
                                    }
                                  })),
                            ),
                          ],
                        ),
                      );

                     }
                      
                     
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
