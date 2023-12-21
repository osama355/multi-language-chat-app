//import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:multichatapp/Screens/chat_Screen/MessageScreen.dart';
import 'package:multichatapp/Service/firebase_service.dart';
import 'package:multichatapp/const/const.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
   
     return  Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: green,
        title: "Chat".text.fontWeight(FontWeight.bold).white.make(),
      ),
     
       body: Column(
         children: [
           Expanded(
             child: StreamBuilder(
              stream: Firebaseservice.getfriend(),
              builder: ( BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot) {
                if(!snapshot.hasData){
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                
                }
               else if(snapshot.connectionState == ConnectionState.waiting){
                return Center(
                  child: "Waiting".text.makeCentered(),
                );
               }
               else if (snapshot.hasError){
                return "Something is Wrong".text.makeCentered();
               }
               else if(snapshot.data!.docs.isEmpty){
                return "No Friends yet".text.makeCentered();
               }
              else{
                dynamic data = snapshot.data!.docs[0];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    
                    Expanded(
                      
                      child: ListView(
                        shrinkWrap: true,
                        children: List.generate(data['friends'].length, (index) {
                          return Column(
                            children: [
                              
                            
           
                              Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                
                                child: ListTile(
                                
                                  onTap: (){
                                    Get.to(()=>  MessageScreen( data: {
                                      'name': data['friends'][index]['name'],
                                      'profile': data['friends'][index]['profile'],

                                      
                                    } ,),
                                    arguments: [
                                      data['friends'][index]['name'],
                                      data['friends'][index]['id'],
                                    
                                    ]);

                                 
                                  },
                                  leading: CircleAvatar(
                                   
                                    radius: 25,
                                    backgroundImage: NetworkImage(
                                      
                                      
                                      data['friends'][index]['profile'])
                                    
                                  ),
                                  
                                  title: "${data['friends'][index]['name']}".text.make(),
                                  
                                 
                                
                                 
                                  
                                )
                              ),
                             const  Divider()
                            ],
                          );
                          
                    
                        })
                      ),
                    ),
                  ],
                ),
              );
                
              }
             },),
           ),
         ],
       )
    );
  }
}