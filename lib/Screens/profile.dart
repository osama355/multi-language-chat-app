

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:multichatapp/Auth/Login.dart';
import 'package:multichatapp/Screens/edit_profile.dart';
import 'package:multichatapp/Screens/friendprofile_Screen/myfriend.dart';
import 'package:multichatapp/Service/firebase_service.dart';
import 'package:multichatapp/Utility/toastmasseage.dart';
import 'package:multichatapp/component/firebase_controller.dart';
import 'package:multichatapp/const/const.dart';
import 'package:multichatapp/controller/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
 final  dynamic data;
  const ProfileScreen({super.key,
  this.data,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var controller = Get.put(ProfileImagePicker());
  var setdata;
  @override
  Widget build(BuildContext context) {
   
    return  Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Profile"),
        actions: [
          "Edit".text.fontWeight(FontWeight.bold).make(),
          IconButton(onPressed: (){
            Get.to(()=> const  Editprofile());
          }, icon:  const  Icon(Icons.edit,color: black))
        ],
      ),
      body: StreamBuilder(
        stream: Firebaseservice.getuser(currentuser!.uid),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
       
        if(!snapshot.hasData){
          return const Center(
            child: CircularProgressIndicator(strokeWidth: 2,color: redColor,),
          );
        }
        
        else{
          var data = snapshot.data!.docs[0];
         
          return  Container(
          height: context.screenHeight * 1,
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(imgbackgorund), fit: BoxFit.fill)),
                  
                  
                  child:   SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                            children: [
                              
                           const   Padding(
                                padding:  EdgeInsets.symmetric(vertical: 20),
                            ),
                            //if data and imagepath is empty.......
                            data['imageurl'] == '' &&  controller.imgpath.isEmpty   ?
                           Image.asset(personimg,width: 70,fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).white.make()
                           //if data is not empty but profilelink is empty.....
                           : data['imageurl'] != '' && controller.profilelink.isEmpty ?
                           
                           Image.network(data['imageurl'],width: 70,fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).white.make():
                           //if both are empty...........
                           Image.file(File(controller.imgpath.value),
                           width: 80,
                           fit: BoxFit.cover,
                           
                           ).box.roundedFull.clip(Clip.antiAlias).white.make(),
                           
                              "${data['name']}".text.white.fontWeight(FontWeight.bold).make(),
                              10.heightBox,

                              ListView.separated(
                                 itemCount: 4,
                                shrinkWrap: true,
                                 separatorBuilder: (context,index){
                                  return const Divider();

                                },
                                itemBuilder: (context, int index){
                                  return ListTile(
                                    title:
                                    Text(
                                   
                                    index == 0 ? data['name'] : index == 1 ? data['email']: index == 2 ? "Add Friends"  : "Logout" ),
                                    
                                     
                                    trailing: index == 0 ? const Icon(Icons.email):index == 1 ? const Icon(Icons.person):index == 2 ? const Icon(Icons.person_add).onTap(() {
                                      Get.off(()=> const FriendHomeScreen() );
                                    }) : const Icon(Icons.logout).onTap(() {
                                       try{
                                         Get.put(AuthController()).signout(context: context);
                                          Get.offAll(const LoginScreen());
                                           }catch(e){
                                            Utils().toastMessage(e.toString());
    }
   
                                     })
                                    
                                    
                                    
                                    //profileiconlist[index],
                                  
                                  );

                                },
                                ).box.white.width(context.screenWidth-40).padding( const EdgeInsets.all(8)).shadowSm.rounded.make(),
                                
                                      
                            ],
                          ),
                    ),
                  ),
                  
     );
        }

      })
     
      
      
     
    );
  }
}