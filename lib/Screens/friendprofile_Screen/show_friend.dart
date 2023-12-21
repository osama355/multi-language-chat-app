import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:multichatapp/Service/firebase_service.dart';
import 'package:multichatapp/const/const.dart';

class ShowFriendScreen extends StatefulWidget {
  const ShowFriendScreen({super.key});

  @override
  State<ShowFriendScreen> createState() => _ShowFriendScreenState();
}

class _ShowFriendScreenState extends State<ShowFriendScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     
       body: StreamBuilder(
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
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: ListTile(
                        leading: CircleAvatar(
                         
                          radius: 30,
                          backgroundImage: NetworkImage(
                            
                            
                            data['friends'][index]['profile'])
                          
                        ),
                        
                        title: "${data['friends'][index]['name']}".text.make(),
                       
                        
                      ),
                    );
              
                  })
                ),
              ),
            ],
          ),
        );
          
        }
       },)
    );
  }
}