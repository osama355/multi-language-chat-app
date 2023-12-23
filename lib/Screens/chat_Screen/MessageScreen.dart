import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multichatapp/Screens/chat_Screen/component/bubblemessage.dart';
import 'package:multichatapp/Service/firebase_service.dart';
import 'package:multichatapp/const/const.dart';
import 'package:multichatapp/controller/chat_controller.dart';

class MessageScreen extends StatelessWidget {
  final dynamic data;
  const MessageScreen({
    super.key,
    this.data,
  });

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(Chatcontroller());

    return Scaffold(
      appBar: AppBar(
        title: "${data['name']}".text.fontWeight(FontWeight.normal).make(),
        actions: [
          CircleAvatar(
              radius: 25, backgroundImage: NetworkImage("${data['profile']}")),
          20.widthBox
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => Column(
            children: [
              controller.isloading.value
                  ? const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: redColor,
                      ),
                    )
                  : Expanded(
                      child: StreamBuilder(
                          stream: Firebaseservice.getallmessage(
                              docid: controller.chatDocId.toString()),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: redColor,
                                ),
                              );
                            } else if (snapshot.data!.docs.isEmpty) {
                              return Center(
                                child: "Send a Message"
                                    .text
                                    .color(Colors.grey.withOpacity(0.7))
                                    .make(),
                              );
                            }
                             else {
                             
                             //controller.updateread();

                            
                              
                              return ListView(
                                children: snapshot.data!.docs
                                    .mapIndexed((currentValue, index) {
                                  var data = snapshot.data!.docs[index];

                                  return Align(
                                      alignment: data['uid'] == currentuser!.uid
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                      child: SendBubble(data: data));
                                      
                                }).toList(),
                              );
                              
                            }
                          }),
                    ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller.msgcontroller,
                      decoration: const InputDecoration(
                          hintText: "Type a message",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: textfieldGrey)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: textfieldGrey,
                          ))),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        controller.sendMsg(controller.msgcontroller.text);
                        controller.msgcontroller.clear();
                      },
                      icon: const Icon(
                        Icons.send,
                        color: Colors.blue,
                      ))
                ],
              )
                  .box
                  .height(90)
                  .padding(const EdgeInsets.all(12))
                  .margin(const EdgeInsets.only(bottom: 2))
                  .make()
            ],
          ),
        ),
      ),
    );
  }
}
