

import 'dart:math';

//import 'package:multichatapp/Auth/Login.dart';
import 'package:multichatapp/Utility/toastmasseage.dart';
import 'package:multichatapp/component/button.dart';
import 'package:multichatapp/component/firebase_controller.dart';
import 'package:multichatapp/const/const.dart';
import 'package:get/get.dart';

class ForgetScreen extends StatefulWidget {
  const ForgetScreen({super.key});

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
   var controller = Get.put(AuthController());
    bool isloading = false;
    var emailcon = TextEditingController();
  
    
    bool isobs = true;
    final keyform = GlobalKey<FormState>();
    @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailcon.dispose();
  }
    
    
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 15, 126, 80),
        title: "Forget password".text.white.fontWeight(FontWeight.bold).make()
      ),
      body: 
          Container(
      height: context.screenHeight *1,
      width: double.infinity,
   
    child: Column(
      
      children: [
        60.heightBox,
        Image.asset(icchat,color: Colors.green,).box.white.roundedSM.padding( const EdgeInsets.all(8)).make(),
    
        15.heightBox,
       Column(
        children: [
          //TextField
        //  customtextfield(title: email,hinttext: emailhint,icon: const Icon(Icons.email),ispass: false,controller: emailcontroller),
         Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
           Form(
            key: keyform,
            
            child: Column(children: [
             Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      email.text.color(black).size(16).make(),
                      TextFormField(
                        controller: emailcon,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter your email';
                          }
                          if (!RegExp(
                                  r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+$')
                              .hasMatch(value)) {
                            return 'Enter correct email';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            hintText: emailhint,
                            suffixIcon: Icon(Icons.email),
                            hintStyle: TextStyle(
                              fontStyle: FontStyle.normal,
                              color: textfieldGrey,
                            ),
                            border: InputBorder.none,
                            fillColor: lightGrey,
                            filled: true,
                            isDense: true,
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: redColor,
                            ))),
                      ),
                      10.heightBox
                    ],
                  ),

           ],)) , 10.heightBox
          ],
        ),
          
          
          
          
         
          
         
          //Login Button..
         ButtonScreen(title: "Send",isloading: isloading, onpress: ()async{
          setState(() {
            isloading = true;
          });
       
       if(keyform.currentState!.validate()){
            auth.sendPasswordResetEmail(email: emailcon.text.toString())
            
            
            .then((value) {
              setState(() {
            isloading = false;
          });
             Utils().toastMessage("We have sent email to recover password, please check email");
             
             emailcon.clear();
            }).onError((error, stackTrace) {
               Utils().toastMessage(e.toString());
               setState(() {
            isloading = false;
          });
            });

       }
            
          
          


         }).box.width(context.screenWidth-50).make(),
        
        ],
       ).box.white.roundedSM.padding( const EdgeInsets.all(8.0)).width(context.screenWidth-70).shadowSm.make(),

       

      ],
    ),
          )
    );

       
  }
}