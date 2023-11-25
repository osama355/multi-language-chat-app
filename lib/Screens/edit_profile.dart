import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:multichatapp/Service/firebase_service.dart';
import 'package:multichatapp/Utility/toastmasseage.dart';
import 'package:multichatapp/component/button.dart';
import 'package:multichatapp/component/textformfield.dart';
import 'package:multichatapp/const/const.dart';
import 'package:multichatapp/controller/profile_controller.dart';

class Editprofile extends StatefulWidget {
  
 
  const Editprofile({super.key,
  

  
  });

  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
 
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileImagePicker>();
     
    
    
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: "Edit profile".text.white.make(),
        backgroundColor: green,
      ),
      body:StreamBuilder(
        stream: Firebaseservice.getuser(currentuser!.uid),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot){
        if(!snapshot.hasData)
        {
        return const  Center(
            child: CircularProgressIndicator(strokeWidth: 2,color: redColor,),
          );
        }

        else{
          var data = snapshot.data!.docs[0];
          controller.namecontroller.text = data['name'];
        

       return  Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(()=>
           Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              controller.imgpath.isEmpty
                  ?   Image.asset(personimg,width: 100,fit: BoxFit.cover,).box.roundedFull.color(green).clip(Clip.antiAlias).make()
                  : Image.file(
                      File(controller.imgpath.value),
                     
                      width: 100,
                      fit: BoxFit.fill,
                    ).box.roundedFull.color(green).clip(Clip.antiAlias).make(),
              5.heightBox,
              SizedBox(
                  width: 100,
                  height: 50,
                  child: ButtonScreen(
                      title: "Edit",
                      buttoncolor: redColor,
                      onpress: () {
                        controller.changeimage();
                      })),
              const Divider(),
              customtextfield(
                
                controller: controller.namecontroller,
                  title: name,
                  hinttext: namehint,
                
                  icon: const  Icon(Icons.person),
                  ispass: false,
                  ),
               Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              oldpass.text.color(black).size(16).make(),
                              TextFormField(
                                controller: controller.passcontroller,
                                validator: (value) {
                                 
                                 
                                  return null;
                                },
                               
                                decoration : const InputDecoration(
                                    hintText: passwordhint,
                                    suffixIcon: Icon(Icons.visibility),
                                    hintStyle:  TextStyle(
                                      fontStyle: FontStyle.normal,
                                      color: textfieldGrey,
                                    ),
                                    border: InputBorder.none,
                                    fillColor: lightGrey,
                                    filled: true,
                                    isDense: true,
                                    focusedBorder:  OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: redColor,
                                    ))),
                              ),
                              10.heightBox
                            ],
                          ),
               Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              newpass.text.color(black).size(16).make(),
                              TextFormField(
                                
                                controller: controller.conformpass,
                                validator: (value) {
                                 
                                  if (value!.length < 6 || value.length > 8) {
                                    return "Password should be between 6 to 8";
                                    
                                    
                                  }
               
                                  return null;
                                },
                              
                                decoration: const InputDecoration(
                                    hintText: passwordhint,
                                    suffixIcon: Icon(Icons.visibility),
                                    hintStyle:  TextStyle(
                                      fontStyle: FontStyle.normal,
                                      color: textfieldGrey,
                                    ),
                                    border: InputBorder.none,
                                    fillColor: lightGrey,
                                    filled: true,
                                    isDense: true,
                                    focusedBorder:  OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: redColor,
                                    ))),
                              ),
                              10.heightBox
                            ],
                          ),
              10.heightBox,
              SizedBox(
                  width: context.screenWidth - 60,
                  child: ButtonScreen(title: "Save",isloading:controller.isloading.value,onpress: () async{
                    controller.isloading(true);

                    //if image is  selected
                    if(controller.imgpath.value.isNotEmpty){
                         await controller.uploadimage();

                    }
                    //if image is not selected
                    else{
                      controller.profilelink = data['imageurl'];

                    }
                    if(controller.passcontroller.text.isEmpty && controller.conformpass.text.isEmpty){
                           await controller.updatedoc(
                            imgurl: controller.profilelink,
                            name: controller.namecontroller.text,
                            password:  data['password']
                           );
                             Utils().toastMessage("Profile Updated");
                            controller.isloading(false);
                            controller.namecontroller.clear();
                           controller.passcontroller.clear();
                           controller.conformpass.clear();


                    }


                    //if passcontroller  text field is matche from database password then perform it.
                   else if(data['password'] == controller.passcontroller.text)
                    {

                     
                       controller.isloading(true);
                        try{
                           controller.changeauthpassword(
                        email: data['email'],
                        password: controller.passcontroller.text,
                        newpass: controller.conformpass.text,
                        

                      );
                       await controller.updatedoc(
                      imgurl: controller.profilelink,
                      name: controller.namecontroller.text,
                      password: controller.conformpass.text,
                    );
                     Utils().toastMessage("Profile Updated");
                    controller.isloading(false);
                    controller.namecontroller.clear();
                    controller.passcontroller.clear();
                    controller.conformpass.clear();

                        }catch(e){
                          Utils().toastMessage(e.toString());
                          controller.isloading(false);

                        }

                      
                     
                    


                       

                    }else{
                      Utils().toastMessage("Password does not matche form old password");
                      controller.isloading(false);
                    }



                 
                  
                   
                  }))
            ],
          )
              .box
              .shadowSm
              .roundedSM
              .padding(const EdgeInsets.all(8))
              .margin(const EdgeInsets.only(top: 50,))
              .white
              .make(),
        ),
      ));

        }



      })
    );
  }
}
